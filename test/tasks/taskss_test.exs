defmodule Tasks.TaskssTest do
  use Tasks.DataCase

  alias Tasks.Taskss

  describe "tasks" do
    alias Tasks.Taskss.Task

    import Tasks.TaskssFixtures

    @invalid_attrs %{}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Taskss.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Taskss.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{}

      assert {:ok, %Task{} = task} = Taskss.create_task(valid_attrs)
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taskss.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{}

      assert {:ok, %Task{} = task} = Taskss.update_task(task, update_attrs)
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Taskss.update_task(task, @invalid_attrs)
      assert task == Taskss.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Taskss.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Taskss.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Taskss.change_task(task)
    end
  end
end
