defmodule Tasks.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tasks.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{

      })
      |> Tasks.Accounts.create_user()

    user
  end
end
