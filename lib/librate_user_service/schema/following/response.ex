defmodule LibrateUserService.Schema.Follow.Response do
  use Ecto.Schema
  import Ecto.Changeset

  schema "follow_responses" do
    field :status, :string
    field :reblogs, :boolean, default: true
    field :notify, :boolean, default: true
    field :error, :string, virtual: true
    field :accept_time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(follow_response, attrs) do
    follow_response
    |> cast(attrs, [:status, :reblogs, :notify, :accept_time])
    |> validate_required([:status])
    |> validate_inclusion(:status, ["accepted", "failed", "pending", "blocked", "already_following", "not_found"])
  end
end
