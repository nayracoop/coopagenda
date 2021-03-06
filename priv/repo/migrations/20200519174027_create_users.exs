defmodule Coopagenda.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :avatar, :string
      add :email, :string
      add :provider, :string
      add :admin, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:users, [:username, :provider])
    create unique_index(:users, [:email, :provider])
  end
end
