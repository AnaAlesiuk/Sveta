defmodule Sveta.Repo do
  use Ecto.Repo,
    otp_app: :sveta,
    adapter: Ecto.Adapters.Postgres
end
