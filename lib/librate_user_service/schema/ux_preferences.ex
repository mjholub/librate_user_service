defmodule LibRateUserService.Schema.UXPreferences do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :locale. :string, default: "en-US"
    field :rating_scale_lower, :integer, default: 1
    field :rating_scale_upper, :integer, default: 10
  end

  @doc false
  def changeset(ux_preferences, attrs) do
    ux_preferences
      |> cast(attrs, [:locale, :rating_scale_lower, :rating_scale_upper])
      |> validate_number(:rating_scale_lower, less_than: :rating_scale_upper, greater_than_or_equal_to: 0, less_than_or_equal_to: 1)
      |> validate_number(:rating_scale_upper, greater_than_or_equal_to: 2, less_than_or_equal_to: 100)
  end
end
