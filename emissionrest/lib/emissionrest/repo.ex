defmodule Emissionrest.Repo do
  use Ecto.Repo,
    otp_app: :emissionrest,
    adapter: Ecto.Adapters.SQLite3
end
