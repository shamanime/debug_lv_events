import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :debug_lv_events, DebugAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "jz1u430eS6xphxjIEj8rS5FZoz7Q/auccSXk8+EriaizOozLccbEWsgv6vBXhYn6",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
