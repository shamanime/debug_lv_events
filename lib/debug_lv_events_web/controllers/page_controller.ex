defmodule DebugAppWeb.PageController do
  use DebugAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
