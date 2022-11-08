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

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :content, :date, :time, :user_id, :project_id])
    |> validate_required([:title, :content, :time, :user_id])
  end

end
