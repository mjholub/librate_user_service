config :librate_user_service, LibRateUserService.Repo,
  # NOTE: not using a database-per-service pattern yet, 
  # need to prepare migrations
  database: "librate_user_service",
  username: "postgres",
  password: "postgres",
  hostname: "0.0.0.0"

config :librate_user_service, LibRateUserService.RabbitMQ,
  connection: "amqp://librate_user:librate_user@librate_rabbitmq:5672"
