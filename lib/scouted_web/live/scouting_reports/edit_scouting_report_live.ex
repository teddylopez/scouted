defmodule ScoutedWeb.EditScoutingReportLive do
  use ScoutedWeb, :live_view

  alias ScoutedWeb.ScoutingReportView
  alias Scouted.Reports
  alias Scouted.Reports.ScoutingReport
  alias Scouted.Accounts
  alias Scouted.Player
  alias Scouted.Repo

  @impl true
  def mount(%{"id" => id}, _, socket) do
    scouting_report = Reports.get_scouting_report!(String.to_integer(id))
    changeset = Reports.change_scouting_report(scouting_report)

    socket =
      assign(socket,
        changeset: changeset,
        scouting_report: scouting_report,
        report_type: scouting_report.report_type,
        current_user: Accounts.get_user!(scouting_report.user_id),
        player: Repo.get_by(Player, id: scouting_report.player_id)
      )

    {:ok, socket}
  end

  def handle_event("validate", %{"scouting_report" => params}, socket) do
    changeset =
      %ScoutingReport{}
      |> Reports.change_scouting_report(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("save", %{"scouting_report" => scouting_report}, socket) do
    report_id = Reports.get_scouting_report!(socket.assigns.scouting_report.id)

    case Reports.update_scouting_report(report_id, scouting_report) do
      {:ok, scouting_report} ->
        {
          :noreply,
          socket
          |> put_flash(:info, "Successfully Updated!")
          |> redirect(to: Routes.scouting_report_path(socket, :show, scouting_report))
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, changeset: changeset)

        {:noreply,
         socket
         |> put_flash(:info, "Unable to submit report.")}
    end
  end
end
