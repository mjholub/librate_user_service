defmodule LibrateUserService.MQ.Consumer do
  use GenServer
  alias LibrateUserService.Repo
  alias LibrateUserService.Schema.{Member,Prefs}
  alias LibrateUserService.Schema.Follow.{Request, Response}

  require Logger
  use AMQP

  @queue "librate_user_service"
  @exchange "librate"
  @routing_key "librate_user_service"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    connect()
    {:ok, state}
  end

  defp connect do
    # TODO: configurability
    with {:ok, conn} <- Connection.open("amqp://librate_user:librate_user@librate_rabbitmq:5672"),
         {:ok, chan} <- Channel.open(conn) do
      Basic.qos(chan, prefetch_count: 1)
      Queue.declare(chan, @queue, durable: true)
      Exchange.declare(chan, @exchange, :direct, durable: true)
      Queue.bind(chan, @queue, @exchange, routing_key: @routing_key)
      {:ok, _consumer_tag} = Basic.consume(chan, @queue, nil, no_ack: false)
      Logger.info("Connected to RabbitMQ")
      {:ok, %{chan: chan, conn: conn}}
    else
      _ ->
        Logger.error("Failed to connect to RabbitMQ")
        :timer.sleep(5000)
        connect()
    end
  end

  def handle_info({:basic_consume_ok, _}, state), do: {:noreply, state}
  def handle_info({:basic_cancel_ok, _}, state), do: {:noreply, state}
  def handle_info({:basic_cancel, _}, state), do: {:stop, :normal, state}

  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, state) do
    consume_message(state.chan, tag, redelivered, payload)
    {:noreply, state}
  end

  defp consume_message(chan, tag, redelivered, payload) do
    payload
    |> Jason.decode()
    |> process_message()

    Basic.ack(chan, tag)
  rescue
    _ ->
      Basic.reject(chan, tag, requeue: not redelivered)
  end

  defp process_message(%{"type" => "create_member", "data" => data}) do
    %Input{}
    |> Input.changeset(data)
    |> Repo.insert()
    |> handle_result("Member created")
  end

  defp process_message(%{"type" => "follow_block_request", "data" => data}) do
    %FollowBlockRequest{}
    |> FollowBlockRequest.changeset(data)
    |> Repo.insert()
    |> handle_result("Follow/block request created")
  end

  defp process_message(%{"type" => "follow_response", "data" => data}) do
    %FollowResponse{}
    |> FollowResponse.changeset(data)
    |> Repo.insert()
    |> handle_result("Follow response created")
  end

  defp process_message(_message) do
    Logger.error("Unknown message type")
  end

  defp handle_result({:ok, _record}, success_message) do
    Logger.info(success_message)
  end

  defp handle_result({:error, changeset}, _failure_message) do
    Logger.error("Failed to process message: #{inspect(changeset.errors)}")
  end
end

