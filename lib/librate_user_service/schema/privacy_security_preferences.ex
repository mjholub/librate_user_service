defmodule LibRateUserService.Schema.PrivacySecurityPreferences do
 use Ecto.Schema
 import Ecto.Changeset

  embedded_schema do
    field :message_autohide_words, {:array, :string}
    field :muted_instances, {:array, :string}
    field :auto_accept_follow, :boolean, default: true
    field :locally_searchable, :boolean, default: true
    field :federated_searchable, :boolean, default: true
    field :robots_searchable, :boolean, default: false
  end

  @doc false
  def changeset(privacy_security_preferences, attrs) do
    privacy_security_preferences
    |> cast(attrs, [:message_autohide_words, :muted_instances, :auto_accept_follow, :locally_searchable, :federated_searchable, :robots_searchable])
  end
end
