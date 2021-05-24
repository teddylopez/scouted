defmodule ScoutedWeb.ScoutingReportLive do
  use ScoutedWeb, :live_view

  alias Scouted.Reports

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       total_reports: Reports.count_reports()
     ), temporary_assigns: [scouting_reports: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    paginate_options = %{page: page, per_page: per_page}
    scouting_reports = Reports.list_scouting_reports(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
        scouting_reports: scouting_reports
      )

    {:noreply, socket}
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: per_page
          )
      )

    {:noreply, socket}
  end

  defp format_name(person) do
    "#{String.capitalize(person.first_name)} #{String.capitalize(person.last_name)}"
  end

  defp report_icon(type) do
    if type == 0, do: "pitcher.png", else: "batter.png"
  end

  defp highlight_grade(grade) when grade <= 49, do: "bg-green-500"
  defp highlight_grade(grade) when grade >= 50 and grade <= 69, do: "bg-yellow-400"
  defp highlight_grade(grade) when grade >= 70, do: "bg-red-500"
  defp highlight_grade(grade), do: "bg-purple-400"

  defp pagination_link(socket, text, page, per_page, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: per_page
        ),
      class: class
    )
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
end
