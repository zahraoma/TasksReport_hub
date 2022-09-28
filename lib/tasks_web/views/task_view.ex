defmodule TasksWeb.TaskView do
  use TasksWeb, :view
  alias TasksWeb.TaskView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    IO.inspect(task)

    %{
      id: task.id,
      title: task.title,
      content: task.content,
      time: task.time
    }
  end
end
