defmodule Tasks.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field(:title, :string)
    field(:content, :string)
    field(:date, :date)
    field(:time, :integer)
    belongs_to(:user, Tasks.Accounts.User)
    belongs_to(:project, Tasks.Projects.Project)

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :content, :date, :time, :user_id, :project_id])
    |> validate_required([:title, :content, :time, :user_id])
  end

  def update_changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :content, :date, :time, :user_id], :project_id)
  end
end
