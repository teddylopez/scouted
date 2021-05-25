defmodule ScoutedWeb.NewScoutingReportLive do
  use ScoutedWeb, :live_view

  alias Scouted.Reports

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, socket}
  end
end
