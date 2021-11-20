defmodule GhWeb.UserController do
  use GhWeb, :controller
  import Neuron

  alias Gh.GhWeb
  alias Gh.GhWeb.User
  alias Gh.GitHubAdapter

  action_fallback GhWeb.FallbackController

  def index(conn, _params) do
    # TODO: move to somewhere as reusable plug or something.
    url = Application.fetch_env!(:github, :url)
    token = Application.fetch_env!(:github, :api_token)
    Neuron.Config.set(url: url)
    Neuron.Config.set(headers: [authorization: "Bearer #{token}"])

    case GitHubAdapter.get_username() do
      {:ok, %Neuron.Response{ body: body }} ->
        username = body["data"]["viewer"]["login"]
        user = %User{ name: username }
        render(conn, "show.json", user: user)

      _ ->
        render(conn, "error.json", %{msg: "cannot connect to github or something error"})
    end
  end

  # def create(conn, %{"user" => user_params}) do
  #   with {:ok, %User{} = user} <- GhWeb.create_user(user_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.user_path(conn, :show, user))
  #     |> render("show.json", user: user)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  # end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = GhWeb.get_user!(id)

  #   with {:ok, %User{} = user} <- GhWeb.update_user(user, user_params) do
  #     render(conn, "show.json", user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = GhWeb.get_user!(id)

  #   with {:ok, %User{}} <- GhWeb.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
