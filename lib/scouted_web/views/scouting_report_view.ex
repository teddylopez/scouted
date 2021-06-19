defmodule ScoutedWeb.ScoutingReportView do
  use ScoutedWeb, :view

  alias Scouted.Repo
  import Ecto.Query, only: [from: 2]

  def format_name(player) do
    "#{player.first_name} #{player.last_name}"
  end

  def convert_report_type(0), do: "Pitcher"
  def convert_report_type(1), do: "Position Player"

  def pitcher_report?(0), do: true
  def pitcher_report?(_), do: false
  def position_report?(1), do: true
  def position_report?(_), do: false

  def render_report_form(0), do: "pitcher_report_form.html"
  def render_report_form(1), do: "pos_report_form.html"

  def convert_date(date) do
    Calendar.strftime(date, "%m/%d/%Y")
  end

  def grade_scale do
    [20, 30, 40, 50, 60, 70, 80]
  end

  def player_options do
    from(player in Scouted.Player,
      order_by: [asc: :last_name]
    )
    |> Repo.all()
    |> Enum.map(&{"#{&1.last_name}, #{&1.first_name}", &1.id})
  end

  def position_options do
    [
      {"All", "all"},
      {"P", :pitcher}
    ] ++
      form_position_options()
  end

  def form_position_options do
    [
      {"C", :catcher},
      {"1B", :first_base},
      {"2B", :second_base},
      {"3B", :third_base},
      {"SS", :short_stop},
      {"LF", :left_field},
      {"CF", :center_field},
      {"RF", :right_field},
      {"DH", :designated_hitter}
    ]
  end

  def calculate_age(date) do
    [mm, dd, yyyy] = date |> String.split("/") |> Enum.map(&String.to_integer/1)
    now = Date.utc_today()

    case now.month > mm || (now.month == mm && now.day >= dd) do
      true -> now.year - yyyy - 0
      false -> now.year - yyyy - 1
    end
  end

  def calculate_age(birthday, date_seen) do
    [mm, dd, yyyy] = date_seen |> String.split("/") |> Enum.map(&String.to_integer/1)
    {:ok, new_date_seen} = Date.new(yyyy, mm, dd)
    [mm, dd, yyyy] = birthday |> String.split("/") |> Enum.map(&String.to_integer/1)

    case new_date_seen.month > mm || (new_date_seen.month == mm && new_date_seen.day >= dd) do
      true -> new_date_seen.year - yyyy - 0
      false -> new_date_seen.year - yyyy - 1
    end
  end

  def translate_position(position) do
    Atom.to_string(position)
    |> String.replace("_", " ", global: false)
    |> String.capitalize()
  end
end
