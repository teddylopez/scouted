defmodule ScoutedWeb.NewScoutingReportLive do
  use ScoutedWeb, :live_view

  alias Scouted.Reports
  alias Scouted.Reports.ScoutingReport
  alias Scouted.Accounts
  alias Scouted.Repo

  @impl true
  def mount(_params, %{"user_token" => user_token}, socket) do
    changeset = Reports.change_scouting_report(%ScoutingReport{})

    socket =
      assign(socket,
        changeset: changeset,
        current_user: Accounts.get_user_by_session_token(user_token)
      )

    {:ok, socket, temporary_assigns: [report_type: nil]}
  end

  @impl true
  def handle_event("new-report-type", %{"report-type" => report_type}, socket) do
    socket =
      push_patch(socket,
        to: Routes.live_path(socket, __MODULE__, report_type: report_type)
      )

    {:noreply, socket}
  end

  @impl true
  def handle_event("save", %{"scouting_report" => params}, socket) do
    case Reports.create_scouting_report(params) do
      {:ok, scouting_report} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Report submitted.")
          |> redirect(to: Routes.scouting_report_path(socket, :show, scouting_report))
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)

        {:noreply,
         socket
         |> put_flash(:info, "Unable to submit report.")}
    end
  end

  @impl true
  def handle_params(%{"report_type" => report_type}, _url, socket) do
    report_type = String.to_integer(report_type)

    socket =
      assign(socket,
        report_type: report_type
      )

    {:noreply, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def render_report_form(0) do
    "new_pitcher_report.html"
  end

  def render_report_form(1) do
    "new_pos_report.html"
  end

  def render_report_form(nil) do
  end
end
