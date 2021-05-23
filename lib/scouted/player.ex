defmodule Scouted.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :first_name, :string
    field :info, :map, default: %{}
    field :last_name, :string
    has_many :scouting_reports, Scouted.Reports.ScoutingReport

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:first_name, :last_name, :info])
    |> validate_required([:first_name, :last_name, :info])
  end
end
