defmodule EatOut.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :pw_hash, :string, null: false

      timestamps()
    end

    create index(:users, [:email], unique: true)

  end
end
