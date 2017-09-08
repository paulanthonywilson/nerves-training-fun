use Mix.Config

config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!, ".ssh/id_rsa.pub"))
  ]

config :logger, level: :info

IO.inspect "hi"

config :bootloader,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: :fw
