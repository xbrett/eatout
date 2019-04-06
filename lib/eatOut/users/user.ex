defmodule EatOut.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :pw_hash, :string
    has_many :reviews, EatOut.Reviews.Review, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :pw_hash])
    |> validate_format(:email, ~r/@/)
    |> validate_required([:name, :email, :pw_hash])
  end
end
