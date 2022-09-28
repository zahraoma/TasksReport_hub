defmodule TasksWeb.PageController do
  use TasksWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
