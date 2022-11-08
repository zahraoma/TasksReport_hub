defmodule Tasks.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:title, :string)
    field(:sum_project, :integer, virtual: true)
    belongs_to(:user, Tasks.Accounts.User)
    has_many(:tasks, Tasks.Tasks.Task)

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
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:user_id, :title])
    |> validate_required([:user_id, :title])
  end
end
