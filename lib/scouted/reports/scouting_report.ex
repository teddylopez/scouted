defmodule Scouted.Reports.ScoutingReport do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scouting_reports" do
    field :details, :map, default: %{}
    field :grade, :integer
    field :report_type, :integer
    belongs_to :player, Scouted.Player
    belongs_to :user, Scouted.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(scouting_report, attrs) do
    scouting_report
    |> cast(attrs, [:details, :grade, :report_type, :player_id, :user_id])
    |> validate_required([:details, :grade, :report_type, :player_id, :user_id])
  end
end
