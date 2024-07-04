defmodule LibrateUserService.Schema.Follow.Request do
  use Ecto.Schema
  import Ecto.Changeset

  schema "follow_block_requests" do
    field :requester, :string
    field :target, :string
    field :reblogs, :boolean, default: true
    field :notify, :boolean, default: true
    field :created, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(follow_block_request, attrs) do
    follow_block_request
    |> cast(attrs, [:requester, :target, :reblogs, :notify, :created])
    |> validate_required([:requester, :target])
  end
end
