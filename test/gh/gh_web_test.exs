defmodule Gh.GhWebTest do
  use Gh.DataCase

  alias Gh.GhWeb

  describe "users" do
    alias Gh.GhWeb.User

    import Gh.GhWebFixtures

    @invalid_attrs %{name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert GhWeb.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert GhWeb.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %User{} = user} = GhWeb.create_user(valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GhWeb.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %User{} = user} = GhWeb.update_user(user, update_attrs)
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = GhWeb.update_user(user, @invalid_attrs)
      assert user == GhWeb.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = GhWeb.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> GhWeb.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = GhWeb.change_user(user)
    end
  end

  describe "repositories" do
    alias Gh.GhWeb.Repository

    import Gh.GhWebFixtures

    @invalid_attrs %{name: nil, url: nil}

    test "list_repositories/0 returns all repositories" do
      repository = repository_fixture()
      assert GhWeb.list_repositories() == [repository]
    end

    test "get_repository!/1 returns the repository with given id" do
      repository = repository_fixture()
      assert GhWeb.get_repository!(repository.id) == repository
    end

    test "create_repository/1 with valid data creates a repository" do
      valid_attrs = %{name: "some name", url: "some url"}

      assert {:ok, %Repository{} = repository} = GhWeb.create_repository(valid_attrs)
      assert repository.name == "some name"
      assert repository.url == "some url"
    end

    test "create_repository/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GhWeb.create_repository(@invalid_attrs)
    end

    test "update_repository/2 with valid data updates the repository" do
      repository = repository_fixture()
      update_attrs = %{name: "some updated name", url: "some updated url"}

      assert {:ok, %Repository{} = repository} = GhWeb.update_repository(repository, update_attrs)
      assert repository.name == "some updated name"
      assert repository.url == "some updated url"
    end

    test "update_repository/2 with invalid data returns error changeset" do
      repository = repository_fixture()
      assert {:error, %Ecto.Changeset{}} = GhWeb.update_repository(repository, @invalid_attrs)
      assert repository == GhWeb.get_repository!(repository.id)
    end

    test "delete_repository/1 deletes the repository" do
      repository = repository_fixture()
      assert {:ok, %Repository{}} = GhWeb.delete_repository(repository)
      assert_raise Ecto.NoResultsError, fn -> GhWeb.get_repository!(repository.id) end
    end

    test "change_repository/1 returns a repository changeset" do
      repository = repository_fixture()
      assert %Ecto.Changeset{} = GhWeb.change_repository(repository)
    end
  end
end
