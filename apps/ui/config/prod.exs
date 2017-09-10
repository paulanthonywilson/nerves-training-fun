use Mix.Config

config :ui, UiWeb.Endpoint,
  http: [port: 80],
  check_origin: false,
  server: true,
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

require Logger
Logger.info "ui prod"

import_config "prod.secret.exs"
