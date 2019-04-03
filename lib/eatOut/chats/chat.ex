defmodule EatOut.Chats.Chat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chats" do
    field :message, :string
    belongs_to :sender, EatOut.Users.User
    belongs_to :reciever, EatOut.Users.User

    timestamps()
  end

  @doc false
  def changeset(chat, attrs) do
    chat
    |> cast(attrs, [:message])
    |> validate_required([:message])
    |> unique_constraint(:no_duplicates, name: :no_dups, message: "Chat already exists")
  end
end
