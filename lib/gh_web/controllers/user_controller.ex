defmodule GhWeb.UserController do
  use GhWeb, :controller

  alias Gh.GhWeb
  alias Gh.GhWeb.User

  action_fallback GhWeb.FallbackController

  def index(conn, _params) do
    users = GhWeb.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- GhWeb.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = GhWeb.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = GhWeb.get_user!(id)

    with {:ok, %User{} = user} <- GhWeb.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = GhWeb.get_user!(id)

    with {:ok, %User{}} <- GhWeb.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
