defmodule LibRateUserService.Schema.Device do
  use Ecto.Schema
  import Ecto.Changeset

  schema "devices" do
    field :friendly_name, :string
    field :known_ips, {:array, :string}
    field :last_login, :utc_datetime
    field :ban_status, :map
    field :id, Ecto.UUID, primary_key: true, autogenerate: true

    timestamps()
  end

  @doc false
  def changeset(device, attrs) do
    device
    |> cast(attrs, [:friendly_name, :known_ips, :last_login, :ban_status])
  end
end
