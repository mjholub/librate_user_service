defmodule LibRateUserService.Schema.Member do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :id, autogenerate: true}
  schema "members" do
    field :uuid, Ecto.UUID, autogenerate: true
    field :passhash, :string
    field :member_name, :string
    field :webfinger, :string
    field :display_name, :string
    field :email, :string
    field :bio, :string
    field :active, :boolean, default: true
    field :roles, {:array, :string}, default: []
    field :reg_timestamp, :utc_datetime
    field :profile_pic_id, :integer
    field :profile_pic_source, :string, virtual: true
    field :visibility, :string
    field :following_uri, :string
    field :followers_uri, :string
    field :session_timeout, :integer
    field :public_key_pem, :string
    field :custom_fields, :map
    field :modified, :integer
    field :added, :integer
    field :doc, :map
    field :doc_id, :string

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [
      :uuid, :passhash, :member_name, :webfinger, :display_name, :email, :bio, :active, :roles, 
      :reg_timestamp, :profile_pic_id, :profile_pic_source, :visibility, :following_uri, :followers_uri, 
      :session_timeout, :public_key_pem, :custom_fields, :modified, :added, :doc, :doc_id
    ])
    |> validate_required([:passhash, :member_name, :webfinger, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:member_name, min: 3, max: 30)
    |> unique_constraint(:member_name)
    |> unique_constraint(:webfinger)
  end
end
