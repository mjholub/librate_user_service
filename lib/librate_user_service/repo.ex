defmodule LibRateUserService.Repo do
  use Ecto.Repo,
    otp_app: :librate_user_service,
    adapter: Ecto.Adapters.Postgres
end
