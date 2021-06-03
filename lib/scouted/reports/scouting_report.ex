defmodule Scouted.Reports.ScoutingReport do
  use Ecto.Schema
  import Ecto.Changeset

  alias Scouted.Details

  schema "scouting_reports" do
    field :grade, :integer
    field :report_type, :integer
    belongs_to :player, Scouted.Player
    belongs_to :user, Scouted.Accounts.User
    embeds_one :details, Details, on_replace: :update

    timestamps()
  end

  @doc false
  def changeset(scouting_report, attrs) do
    scouting_report
    |> cast(attrs, [:grade, :report_type, :player_id, :user_id])
    |> validate_required([:grade, :report_type, :player_id, :user_id])
    |> cast_embed(:details)
  end
end
