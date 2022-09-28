defmodule Tasks.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :content, :string
      add :time, :integer
      add :user_id, references(:users)
      timestamps()
    end
  end
end
