defmodule GhWeb.RepositoryController do
  use GhWeb, :controller

  alias Gh.GhWeb
  alias Gh.GhWeb.Repository
  alias Gh.GitHubAdapter

  action_fallback GhWeb.FallbackController

  defp convert_edge_to_repo(edge) do
    alias Gh.GhWeb.Repository
    node = edge["node"]
    %Repository {
      id: node["id"],
      url: node["url"],
      name: node["nameWithOwner"]
    }
  end

  def index(conn, _params) do
    # connection
    # TODO: move to somewhere as reusable plug or something.
    url = Application.fetch_env!(:github, :url)
    token = Application.fetch_env!(:github, :api_token)
    Neuron.Config.set(url: url)
    Neuron.Config.set(headers: [authorization: "Bearer #{token}"])

    case GitHubAdapter.get_watching_repositories()  do
      {:ok, %Neuron.Response{ body: body }} ->
        list =
          body["data"]["viewer"]["watching"]["edges"]
          |> Enum.map(&convert_edge_to_repo/1)
        render(conn, "index.json", repositories: list)

      _ ->
        render(conn, "error.json", %{msg: "cannot connect to github or something error"})
    end
  end
end
