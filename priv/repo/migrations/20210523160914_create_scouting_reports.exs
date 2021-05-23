defmodule Scouted.Repo.Migrations.CreateScoutingReports do
  use Ecto.Migration

  def change do
    create table(:scouting_reports) do
      add :report_type, :integer, null: false
      add :grade, :integer, null: false
      add :details, :jsonb, null: false
      add :player_id, references(:players, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:scouting_reports, [:player_id])
    create index(:scouting_reports, [:user_id])
  end
end
