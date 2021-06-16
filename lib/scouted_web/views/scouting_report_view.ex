defmodule ScoutedWeb.ScoutingReportView do
  use ScoutedWeb, :view

  alias Scouted.Accounts.User
  alias Scouted.Reports.ScoutingReport
  alias Scouted.Repo
  import Ecto.Query, only: [from: 2]

  def format_name(player) do
    "#{player.first_name} #{player.last_name}"
  end

  def convert_report_type(0), do: "Pitcher"
  def convert_report_type(1), do: "Position Player"
  def convert_report_type("all"), do: "All Reports"

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
    [20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80]
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
    {:ok, new_birthday} = Date.new(yyyy, mm, dd)

    case new_date_seen.month > mm || (new_date_seen.month == mm && new_date_seen.day >= dd) do
      true -> new_date_seen.year - yyyy - 0
      false -> new_date_seen.year - yyyy - 1
    end
  end

  def author_type_options do
    Repo.all(
      from(sr in ScoutingReport,
        join: u in User,
        on: sr.user_id == u.id,
        group_by: u.id,
        order_by: u.email,
        select: {u.email, u.id}
      )
    )
  end

  def humanize_filter_params(:author_id, id) do
    case id do
      "all" ->
        "Written by: All"

      _ ->
        [{email}] =
          Repo.all(
            from(u in User,
              where: u.id == ^id,
              order_by: u.email,
              select: {u.email}
            )
          )

        "Written by: #{email}"
    end
  end

  def humanize_filter_params(:report_type, id) do
    type = convert_report_type(id)

    "Report type: #{type}"
  end

  def humanize_filter_params(_key, _value) do
    nil
  end
end
