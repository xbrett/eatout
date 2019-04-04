defmodule EatOut.Users.User do
  use Ecto.Schema
  use Arc.Ecto.Model
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :pw_hash, :string
    field :avatar, EatOut.Avatar.Type

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :pw_hash, :avatar])
    |> validate_required([:name, :email, :pw_hash])
  end
end
