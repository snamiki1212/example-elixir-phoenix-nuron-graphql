defmodule GhWeb.RepositoryController do
  use GhWeb, :controller

  alias Gh.GhWeb
  alias Gh.GhWeb.Repository

  action_fallback GhWeb.FallbackController

  def get_watching_repositories do
    # after_cursor = "" # TODO: use after cursor REF: https://stackoverflow.com/a/48117383
    per = 100
    Neuron.query("""
    query FetchWatchingRepositories { 
      viewer { 
        watching (first: #{per}) {
          edges {
            node {
              id
              url
              nameWithOwner
            }
          }
        }
      }
    }
    """
    )
  end

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
    result = get_watching_repositories() 

    # IO.inspect(result)

    list = case result do
      {:ok, %Neuron.Response{
        body: body
      }} -> body["data"]["viewer"]["watching"]["edges"]

      # TODO: error handling
      _ -> []
    end
    # IO.inspect(list)

    # require IEx; IEx.pry
    list = Enum.map(list, &convert_edge_to_repo/1)

    # 
    render(conn, "index.json", repositories: list)
  end
end
