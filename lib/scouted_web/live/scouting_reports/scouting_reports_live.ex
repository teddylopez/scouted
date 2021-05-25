defmodule ScoutedWeb.ScoutingReportsLive do
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
    sort_by = (params["sort_by"] || "grade") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    scouting_reports =
      Reports.list_scouting_reports(paginate: paginate_options, sort: sort_options)

    socket =
      assign(socket,
        options: Map.merge(paginate_options, sort_options),
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
            per_page: per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order
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

  defp pagination_link(socket, text, page, options, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: options.per_page,
          sort_by: options.sort_by,
          sort_order: options.sort_order
        ),
      class: class
    )
  end

  def sort_link(socket, text, sort_by, options) do
    text =
      if sort_by == options.sort_by do
        text <> style_order(options.sort_order)
      else
        text
      end

    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          sort_by: sort_by,
          sort_order: toggle_sort_order(options.sort_order),
          page: 1,
          per_page: options.per_page
        )
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

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp style_order(:asc), do: " ▲"
  defp style_order(:desc), do: " ▼"
end