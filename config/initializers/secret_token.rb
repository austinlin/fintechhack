# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
PrivateEquity::Application.config.secret_token = ENV['RAILS_SECRET_TOKEN'] || '45a6061a0b6a3cda4cb5c6d7f8968ad1ab15d77ab3d0f5b35344c096843f2d2cdfb4a528ab1d07cec66f455e1f9bb49cc4ac7bd1ebea41f315d87317f3ced28d'
