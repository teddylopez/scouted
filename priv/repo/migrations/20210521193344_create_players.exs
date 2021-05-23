defmodule Scouted.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :first_name, :string
      add :last_name, :string
      add :info, :jsonb

      timestamps()
    end
  end
end
