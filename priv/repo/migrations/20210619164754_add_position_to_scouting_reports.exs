defmodule Scouted.Repo.Migrations.AddPositionToScoutingReports do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE position_id AS ENUM (
    'pitcher',
    'catcher',
    'first_base',
    'second_base',
    'third_base',
    'short_stop',
    'left_field',
    'center_field',
    'right_field',
    'designated_hitter'
    )")

    alter table(:scouting_reports) do
      add :position, :position_id
    end
  end

  def down do
    alter table(:scouting_reports) do
      add :position, :position_id
    end

    execute("DROP TYPE position_id")
  end
end
