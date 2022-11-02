defmodule Tasks.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :age, :integer
      add :email, :string
      # add :sum_tasks, :integer

      timestamps()
    end
  end
end
