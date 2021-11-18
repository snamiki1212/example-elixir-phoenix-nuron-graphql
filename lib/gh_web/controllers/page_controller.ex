defmodule GhWeb.PageController do
  use GhWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
