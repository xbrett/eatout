defmodule EatOut.Friends.Friend do
  use Ecto.Schema
  import Ecto.Changeset

  schema "friends" do
    belongs_to :friender, EatOut.Users.User, foreign_key: :friender_id
    belongs_to :freindee, EatOut.Users.User, foreign_key: :friendee_id
    field :confirmed, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(friend, attrs) do
    IO.inspect(friend)
    IO.inspect(attrs)
    friend
    |> cast(attrs, [:friender_id, :friendee_id, :confirmed])
    # |> unique_constraint([:friender_id, :friendee_id])
    |> validate_required([:friender_id, :friendee_id, :confirmed])
  end
end
