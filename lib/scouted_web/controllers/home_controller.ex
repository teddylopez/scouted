defmodule ScoutedWeb.HomeController do
  use ScoutedWeb, :controller

  def index(conn, _params) do
    hi = "hi"
    render(conn, "index.html")
  end

  # def recents(conn, %{"recents" => recents}) do
  #   render(conn, "show.html", recents: recents)
  # end
end
