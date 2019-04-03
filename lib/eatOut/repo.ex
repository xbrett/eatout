defmodule EatOut.Repo do
  use Ecto.Repo,
    otp_app: :eatOut,
    adapter: Ecto.Adapters.Postgres
end
