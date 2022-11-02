defmodule Tasks.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :user_id, references(:users, on_delete: :nilify_all)
      timestamps()
    end
  end
end
