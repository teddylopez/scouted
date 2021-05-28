defmodule ScoutedWeb.ScoutingReportView do
  use ScoutedWeb, :view

  def format_name(player) do
    "#{player.first_name} #{player.last_name}"
  end

  def convert_report_type(0), do: "Pitcher"
  def convert_report_type(1), do: "Position Player"
end
