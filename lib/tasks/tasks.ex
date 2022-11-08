defmodule Tasks.Tasks do
  @moduledoc """
  The Taskss context.
  """

  import Ecto.Query, warn: false
  alias Tasks.Repo
  alias Tasks.Accounts.User

  alias Tasks.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def sum_tasks(user_id, sdate, edate) do
    Repo.one(
      from t in Task,
        where: t.user_id == ^user_id and t.date >= ^sdate and t.date <= ^edate,
        select: sum(t.time)
    )
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
