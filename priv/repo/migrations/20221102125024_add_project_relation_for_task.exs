defmodule Tasks.Repo.Migrations.AddProjectRelationForTask do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :project_id, references(:projects)
    end
  end
end
