defmodule Tasks.TaskssFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tasks.Taskss` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{

      })
      |> Tasks.Taskss.create_task()

    task
  end
end
