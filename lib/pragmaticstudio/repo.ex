defmodule Pragmaticstudio.Repo do
  use Ecto.Repo,
    otp_app: :pragmaticstudio,
    adapter: Ecto.Adapters.Postgres
end
