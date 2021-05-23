defmodule Scouted.Repo do
  use Ecto.Repo,
    otp_app: :scouted,
    adapter: Ecto.Adapters.Postgres
end
