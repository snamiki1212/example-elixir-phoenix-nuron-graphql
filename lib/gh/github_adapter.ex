defmodule Gh.GitHubAdapter do
  def get_username do
    Neuron.query("""
    query GetUserName { 
      viewer { 
        login
      }
    }
    """
    )
  end

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
end