defmodule Tasks.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias Tasks.Repo

  alias Tasks.Projects.Project
  alias Tasks.Tasks.Task

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end


  def get_project!(id), do: Repo.get!(Project, id)


  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def sum_project(project_id, sdate, edate) do
    Repo.one(
      from t in Task,
        where: t.project_id == ^project_id and t.date >= ^sdate and t.date <= ^edate,
        select: sum(t.time)
    )
  end


  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end


  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end
end
