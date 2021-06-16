defmodule ScoutedWeb.ScoutingReportsLive do
  use ScoutedWeb, :live_view

  alias Scouted.Reports
  alias ScoutedWeb.ScoutingReportView

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       total_reports: Reports.count_reports()
     ), temporary_assigns: [scouting_reports: []]}
  end

  @impl true
  def handle_event("filter", %{"author" => author_id} = params, socket) do
    socket =
      push_patch(socket,
        to: Routes.live_path(socket, __MODULE__, author_id: author_id)
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = String.to_integer(per_page)

    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: socket.assigns.options.report_type,
            author_id: socket.assigns.options.author_id
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("select-report-type", %{"report-type" => report_type}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: report_type,
            author_id: socket.assigns.options.author_id
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "10")
    sort_by = (params["sort_by"] || "grade") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()
    report_type = translate_report_type(params)
    author_id = params["author_id"] || "all"

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}
    report_options = %{report_type: report_type}
    author_options = %{author_id: author_id}

    scouting_reports =
      Reports.list_scouting_reports(
        paginate: paginate_options,
        sort: sort_options,
        report_type: report_options,
        author_id: author_options
      )

    query_options = %{
      page: page,
      per_page: per_page,
      sort_by: sort_by,
      sort_order: sort_order,
      report_type: report_type,
      author_id: author_id
    }

    socket =
      assign(socket,
        options: query_options,
        scouting_reports: scouting_reports,
        total_reports: Reports.count_reports(query_options)
      )

    {:noreply, socket}
  end

  def pagination_link(socket, text, page, options, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: options.per_page,
          sort_by: options.sort_by,
          sort_order: options.sort_order,
          report_type: options.report_type,
          author_id: options.author_id
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
          per_page: options.per_page,
          report_type: options.report_type,
          author_id: options.author_id
        )
    )
  end

  defp translate_report_type(%{"report_type" => report_type} = params) do
    case report_type do
      "0" ->
        0

      "1" ->
        1

      _ ->
        "all"
    end
  end

  defp translate_report_type(%{} = _params) do
    "all"
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
  defp highlight_grade(_grade), do: "bg-purple-400"

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp style_order(:asc), do: " ▲"
  defp style_order(:desc), do: " ▼"
end
