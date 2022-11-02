defmodule Tasks.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tasks.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{

      })
      |> Tasks.Projects.create_project()

    project
  end
end
