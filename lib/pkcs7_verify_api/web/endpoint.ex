defmodule PKCS7Verify.Web.Endpoint do
  @moduledoc """
  Phoenix Endpoint for pkcs7_verify_api application.
  """
  use Phoenix.Endpoint, otp_app: :pkcs7_verify_api

  plug Plug.RequestId
  plug EView.Plugs.Idempotency
  plug Plug.Logger

  plug EView

  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug PKCS7Verify.Web.Router

  @doc """
  Dynamically loads configuration from the system environment
  on startup.

  It receives the endpoint configuration from the config files
  and must return the updated configuration.
  """
  def load_from_system_env(config) do
    config = Confex.process_env(config)

    unless config[:secret_key_base] do
      raise "Set SECRET_KEY environment variable!"
    end

    {:ok, config}
  end
end
