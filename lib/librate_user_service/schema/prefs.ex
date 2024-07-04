defmodule LibRateUserService.Schema.Prefs do
  use Ecto.Schema
  import Ecto.Changeset 

  embedded_schema do
    embeds_one :ux, LibRateUserService.Schema.UXPreferences
    embeds_one :privacy_security, LibRateUserService.Schema.PrivacySecurityPreferences
  end

  @doc false
  def changeset(preferences, attrs) do
    preferences
    |> cast(attrs, [])
    |> cast_embed(:ux)
    |> cast_embed(:privacy_security)
  end
end
