defmodule GhWeb.RepositoryView do
  use GhWeb, :view
  alias GhWeb.RepositoryView

  def render("index.json", %{repositories: repositories}) do
    %{data: render_many(repositories, RepositoryView, "repository.json")}
  end

  def render("show.json", %{repository: repository}) do
    %{data: render_one(repository, RepositoryView, "repository.json")}
  end

  def render("repository.json", %{repository: repository}) do
    %{
      id: repository.id,
      name: repository.name,
      url: repository.url
    }
  end
end
