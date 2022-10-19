defmodule Tasks.Tasks do
  @moduledoc """
  The Taskss context.
  """

  import Ecto.Query, warn: false
  alias Ecto.Multi
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

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    user_id = attrs["user_id"]
    user_data = Repo.get(User, user_id)

    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, task} ->
        %User{id: user_id}
        |> User.update_changeset(%{"sum_tasks" => user_data.sum_tasks + task.time})
        |> Repo.update()

        {:ok, task}

      # # solution 2
      # Repo.update_all(
      #   from u in User,
      #     where: u.id == ^user_id,
      #     update: [set: [sum_tasks: u.sum_tasks + ^task.time]]
      # )
      error ->
        error
    end
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # Repo.update(
  # from u in User,
  # where: u.id == ^user_id,
  # update: [set: [sum_tasks: u.sum_tasks + ^task.time - ^t1]]
  # )
  # IO.inspect "------------------------"

  def update_task(
        %Task{id: task_id, user_id: user_id, time: time} = task,
        %{"time" => new_time} = attrs
      ) do
    # time =
    #   Repo.one(
    #     from u in Task,
    #       where: u.id == ^task_id,
    #       select: u.time
    #   )
    Multi.new()
    |> Multi.update_all(
      "update sum tasks in user data",
      from(
        u in User,
        where: u.id == ^user_id
      ),
      inc: [sum_tasks: new_time - time]
    )
    |> Multi.update("update task", Task.update_changeset(%Task{id: task_id}, attrs))
    |> Repo.transaction()
    |> IO.inspect()
    |> case do
      {:ok, %{"update task" => updated_task}} -> {:ok, updated_task}
      _ -> {:error, :not_found}
    end

    # task
    #  |> Task.changeset(attrs)
    #  |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{user_id: user_id, time: time} = task, _attrs \\ %{}) do
    IO.inspect(user_id)

    Multi.new()
    |> Multi.update_all(
      "update sum tasks in user data",
      from(u in User,
        where: u.id == ^user_id
      ),
      inc: [sum_tasks: 0 - time]
    )
    |> Multi.delete("delete task", task)
    |> Repo.transaction()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
