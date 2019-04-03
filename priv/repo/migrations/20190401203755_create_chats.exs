defmodule EatOut.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do
      add :message, :string
      add :sender_id, references(:users, on_delete: :delete_all), null: false, primary_key: true
      add :reciever_id, references(:users, on_delete: :delete_all), null: false, primary_key: true

      timestamps()
    end

    create index(:chats, [:sender_id])
    create index(:chats, [:reciever_id])
    create unique_index(:chats, [:sender_id, :reciever_id], name: :no_dups)

  end
end
