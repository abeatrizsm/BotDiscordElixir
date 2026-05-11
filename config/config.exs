import Config
config :nostrum,
  token: System.get_env("BOT_TOKEN"),
  gateway_intents: :all,
  ffmpeg: false
