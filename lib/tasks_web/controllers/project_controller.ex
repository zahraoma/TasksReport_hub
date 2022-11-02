defmodule TasksWeb.ProjectController do
  use TasksWeb, :controller

  alias Tasks.Projects
  alias Tasks.Projects.Project

  action_fallback TasksWeb.FallbackController

  def index(conn, _params) do
    projects = Projects.list_projects()
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    with {:ok, %Project{} = project} <- Projects.create_project(project_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.project_path(conn, :show, project))
      |> render("show.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Projects.get_project!(id)
    render(conn, "show.json", project: project)
  end

  def show_sum_project(conn, %{"project_id" => project_id, "sdate" => sdate, "edate" => edate}) do
    with {:ok, sdate} <- Date.from_iso8601(sdate),
         {:ok, edate} <- Date.from_iso8601(edate) do
      sum = Projects.sum_project(project_id, sdate, edate)
      json(conn, %{sum: sum})
    end

    # case Date.from_iso8601(sdate) do
    #   {:ok, date} ->
    #     sum = Projects.sum_project(id_project, sdate, edate)
    #     json(conn, %{sum: sum})

    #   _ ->
    #     {:error, :invalid_date}
    # end

    # render(conn, "show.json", project: project)
  end

  def show_sum_project(conn, _params) do
    IO.inspect("---------------------------------")
    IO.inspect(_params)
    IO.inspect("---------------------------------")

    conn
    |> send_resp(:unprocessable_entity, "unprocessable entity")

    # |> send_resp("422" ,  "unprocessable entity")
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{} = project} <- Projects.update_project(project, project_params) do
      render(conn, "show.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Projects.get_project!(id)

    with {:ok, %Project{}} <- Projects.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
