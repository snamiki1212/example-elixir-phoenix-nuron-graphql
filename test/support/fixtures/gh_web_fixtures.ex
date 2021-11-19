defmodule Gh.GhWebFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gh.GhWeb` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Gh.GhWeb.create_user()

    user
  end

  @doc """
  Generate a repository.
  """
  def repository_fixture(attrs \\ %{}) do
    {:ok, repository} =
      attrs
      |> Enum.into(%{
        name: "some name",
        url: "some url"
      })
      |> Gh.GhWeb.create_repository()

    repository
  end
end
