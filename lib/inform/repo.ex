defmodule Inform.Repo do
  use Ecto.Repo,
    otp_app: :inform,
    adapter: Ecto.Adapters.Postgres
end
