defmodule Gh.Repo do
  use Ecto.Repo,
    otp_app: :gh,
    adapter: Ecto.Adapters.Postgres
end
