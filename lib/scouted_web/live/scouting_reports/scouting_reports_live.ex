defmodule ScoutedWeb.ScoutingReportsLive do
  use ScoutedWeb, :live_view

  import Ecto.Query, warn: false
  alias Scouted.Repo
  alias Scouted.Reports
  alias ScoutedWeb.ScoutingReportView
  alias Scouted.Reports.ScoutingReport
  alias Scouted.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       total_reports: Reports.count_reports()
     )}
  end

  @impl true
  def handle_event("show-report", %{"scouting-report" => id}, socket) do
    {
      :noreply,
      socket
      |> redirect(to: Routes.scouting_report_path(socket, :show, id))
    }
  end

  @impl true
  def handle_event("filter-report-type", %{"report-type" => report_type}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: report_type,
            author_id: socket.assigns.options.author_id,
            min_grade: socket.assigns.options.min_grade,
            max_grade: socket.assigns.options.max_grade,
            earliest: socket.assigns.options.earliest,
            latest: socket.assigns.options.latest
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("filter-author", %{"author" => author_id}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: socket.assigns.options.report_type,
            author_id: author_id,
            min_grade: socket.assigns.options.min_grade,
            max_grade: socket.assigns.options.max_grade,
            earliest: socket.assigns.options.earliest,
            latest: socket.assigns.options.latest
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("filter-min-grade", %{"min-grade" => min_grade}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: socket.assigns.options.report_type,
            author_id: socket.assigns.options.author_id,
            min_grade: min_grade,
            max_grade: socket.assigns.options.max_grade,
            earliest: socket.assigns.options.earliest,
            latest: socket.assigns.options.latest
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("filter-max-grade", %{"max-grade" => max_grade}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: socket.assigns.options.report_type,
            author_id: socket.assigns.options.author_id,
            min_grade: socket.assigns.options.min_grade,
            max_grade: max_grade,
            earliest: socket.assigns.options.earliest,
            latest: socket.assigns.options.latest
          )
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
            author_id: socket.assigns.options.author_id,
            min_grade: socket.assigns.options.min_grade,
            max_grade: socket.assigns.options.max_grade,
            earliest: socket.assigns.options.earliest,
            latest: socket.assigns.options.latest
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("filter-earliest", %{"earliest" => earliest}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: socket.assigns.options.report_type,
            author_id: socket.assigns.options.author_id,
            min_grade: socket.assigns.options.min_grade,
            max_grade: socket.assigns.options.max_grade,
            earliest: earliest,
            latest: socket.assigns.options.latest
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("filter-latest", %{"latest" => latest}, socket) do
    socket =
      push_patch(socket,
        to:
          Routes.live_path(socket, __MODULE__,
            page: 1,
            per_page: socket.assigns.options.per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order,
            report_type: socket.assigns.options.report_type,
            author_id: socket.assigns.options.author_id,
            min_grade: socket.assigns.options.min_grade,
            max_grade: socket.assigns.options.max_grade,
            earliest: socket.assigns.options.earliest,
            latest: latest
          )
      )

    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "10")
    sort_by = (params["sort_by"] || "updated_at") |> String.to_atom()
    sort_order = (params["sort_order"] || "desc") |> String.to_atom()
    report_type = translate_report_type(params)
    author_id = params["author_id"] || "all"
    min_grade = params["min_grade"] || "20"
    max_grade = params["max_grade"] || "80"
    earliest = get_earliest(params)
    latest = get_latest(params)

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}
    report_options = %{report_type: report_type}
    author_options = %{author_id: author_id}
    grade_options = %{min_grade: min_grade, max_grade: max_grade}
    date_options = %{earliest: earliest, latest: latest}

    scouting_reports =
      Reports.list_scouting_reports(
        paginate: paginate_options,
        sort: sort_options,
        report_type: report_options,
        author_id: author_options,
        grade: grade_options,
        date: date_options
      )

    query_options = %{
      page: page,
      per_page: per_page,
      sort_by: sort_by,
      sort_order: sort_order,
      report_type: report_type,
      author_id: author_id,
      min_grade: min_grade,
      max_grade: max_grade,
      earliest: earliest,
      latest: latest
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
          author_id: options.author_id,
          min_grade: options.min_grade,
          max_grade: options.max_grade,
          earliest: options.earliest,
          latest: options.latest
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
          author_id: options.author_id,
          min_grade: options.min_grade,
          max_grade: options.max_grade,
          earliest: options.earliest,
          latest: options.latest
        )
    )
  end

  defp translate_report_type(%{"report_type" => report_type}) do
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

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp style_order(:asc), do: " ▲"
  defp style_order(:desc), do: " ▼"

  defp earliest_date do
    [report] =
      from(scouting_report in ScoutingReport,
        order_by: [asc: :updated_at],
        limit: 1
      )
      |> Repo.all()

    report.updated_at
    |> DateTime.from_naive!("Etc/UTC")
    |> Calendar.strftime("%Y-%m-%d")
  end

  defp todays_date do
    NaiveDateTime.utc_now()
    |> DateTime.from_naive!("Etc/UTC")
    |> Calendar.strftime("%Y-%m-%d")
  end

  defp get_earliest(params) do
    earliest = params["earliest"]

    case earliest do
      "" -> earliest_date()
      nil -> earliest_date()
      earliest -> earliest
    end
  end

  defp get_latest(params) do
    latest = params["latest"]

    case latest do
      "" -> todays_date()
      nil -> todays_date()
      latest -> latest
    end
  end

  def grade_scale do
    [20, 30, 40, 50, 60, 70, 80]
  end

  def report_type_options do
    [{"All", "all"}, {"Pitcher", 0}, {"Batter", 1}]
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
end
