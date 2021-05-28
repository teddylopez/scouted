defmodule ScoutedWeb.ScoutingReportController do
  use ScoutedWeb, :controller

  alias Scouted.Reports
  alias Scouted.Reports.ScoutingReport
  alias Scouted.Repo

  def index(conn, _params) do
    scouting_reports = Reports.list_scouting_reports()
    render(conn, "index.html", scouting_reports: scouting_reports)
  end

  def new(conn, _params) do
    changeset = Reports.change_scouting_report(%ScoutingReport{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"scouting_report" => scouting_report_params}) do
    case Reports.create_scouting_report(scouting_report_params) do
      {:ok, scouting_report} ->
        conn
        |> put_flash(:info, "Scouting report created successfully.")
        |> redirect(to: Routes.scouting_report_path(conn, :show, scouting_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    scouting_report =
      Reports.get_scouting_report!(id)
      |> Repo.preload([:player, :user])

    render(conn, "show.html", scouting_report: scouting_report)
  end

  def edit(conn, %{"id" => id}) do
    scouting_report = Reports.get_scouting_report!(id)
    changeset = Reports.change_scouting_report(scouting_report)
    render(conn, "edit.html", scouting_report: scouting_report, changeset: changeset)
  end

  def update(conn, %{"id" => id, "scouting_report" => scouting_report_params}) do
    scouting_report = Reports.get_scouting_report!(id)

    case Reports.update_scouting_report(scouting_report, scouting_report_params) do
      {:ok, scouting_report} ->
        conn
        |> put_flash(:info, "Scouting report updated successfully.")
        |> redirect(to: Routes.scouting_report_path(conn, :show, scouting_report))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", scouting_report: scouting_report, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    scouting_report = Reports.get_scouting_report!(id)
    {:ok, _scouting_report} = Reports.delete_scouting_report(scouting_report)

    conn
    |> put_flash(:info, "Scouting report deleted successfully.")
    |> redirect(to: Routes.scouting_report_path(conn, :index))
  end
end
