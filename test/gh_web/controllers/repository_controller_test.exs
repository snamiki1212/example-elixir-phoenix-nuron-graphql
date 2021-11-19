defmodule GhWeb.RepositoryControllerTest do
  use GhWeb.ConnCase

  import Gh.GhWebFixtures

  alias Gh.GhWeb.Repository

  @create_attrs %{
    name: "some name",
    url: "some url"
  }
  @update_attrs %{
    name: "some updated name",
    url: "some updated url"
  }
  @invalid_attrs %{name: nil, url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all repositories", %{conn: conn} do
      conn = get(conn, Routes.repository_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create repository" do
    test "renders repository when data is valid", %{conn: conn} do
      conn = post(conn, Routes.repository_path(conn, :create), repository: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.repository_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.repository_path(conn, :create), repository: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update repository" do
    setup [:create_repository]

    test "renders repository when data is valid", %{conn: conn, repository: %Repository{id: id} = repository} do
      conn = put(conn, Routes.repository_path(conn, :update, repository), repository: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.repository_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, repository: repository} do
      conn = put(conn, Routes.repository_path(conn, :update, repository), repository: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete repository" do
    setup [:create_repository]

    test "deletes chosen repository", %{conn: conn, repository: repository} do
      conn = delete(conn, Routes.repository_path(conn, :delete, repository))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.repository_path(conn, :show, repository))
      end
    end
  end

  defp create_repository(_) do
    repository = repository_fixture()
    %{repository: repository}
  end
end
