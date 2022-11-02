defmodule Tasks.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:age, :integer)
    field(:email, :string)
    # field(:sum_tasks, :integer, default: 0)
    has_many(:tasks, Tasks.Tasks.Task)


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age, :email])
    |> validate_required([:name, :age, :email])
    |> validate_length(:name, max: 15)
  end

  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:sum_tasks])
  end
end
