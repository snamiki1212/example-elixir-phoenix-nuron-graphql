defmodule GhWeb.UserView do
  use GhWeb, :view
  alias GhWeb.UserView

  # def render("index.json", %{users: users}) do
  #   %{data: render_many(users, UserView, "user.json")}
  # end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name
    }
  end

  def render("error.json", %{msg: msg}) do
    %{errors: msg}
  end
end
