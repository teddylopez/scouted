defmodule ScoutedWeb.ScoutingReportView do
  use ScoutedWeb, :view

  def format_name(player) do
    "#{player.first_name} #{player.last_name}"
  end

  def convert_report_type(0), do: "Pitcher"
  def convert_report_type(1), do: "Position Player"

  def pitcher_report?(0), do: true
  def pitcher_report?(_), do: false
  def position_report?(1), do: true
  def position_report?(_), do: false

  def render_report_form(0) do
    "pitcher_report_form.html"
  end

  def render_report_form(1) do
    "pos_report_form.html"
  end

  def render_report_form(nil) do
  end

  def convert_date(date) do
    Calendar.strftime(date, "%m/%d/%Y")
  end

  def calculate_age(date) do
    [mm, dd, yyyy] = date |> String.split("/") |> Enum.map(&String.to_integer/1)
    now = Date.utc_today()

    case now.month > mm || (now.month == mm && now.day >= dd) do
      true -> now.year - yyyy - 0
      false -> now.year - yyyy - 1
    end
  end

  def save_or_update(id) do
    IO.puts("update")
    "update"
  end

  def save_or_update do
    IO.puts("save")
    "save"
  end
end
