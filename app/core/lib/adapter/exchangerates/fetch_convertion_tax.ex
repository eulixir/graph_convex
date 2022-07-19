defmodule Core.Adapters.FetchConvertionTax.ExchangeRates do
  @moduledoc """
  Adapter for ExchangeRates implements FetchConvertionTax
  """

  @behaviour Core.Ports.FetchConvertionTax

  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://api.exchangeratesapi.io/v1/")
  plug(Tesla.Middleware.JSON)

  require Logger

  @impl true
  def fetch_convertion_tax(currency) do
    case fetch_api(currency) do
      {:ok, %Tesla.Env{status: 200, body: %{"rates" => result}}} ->
        {:ok, Map.get(result, currency)}

      {:ok, %Tesla.Env{status: status, body: return}} ->
        Logger.warn(
          "An error occur when request: Status: #{status}, Reason:" <> Jason.encode!(return),
          []
        )

        {:error, "Occur an error while fetch api, try again"}
    end
  end

  defp fetch_api(currency) do
    System.get_env("EXCHANGE_RATES_ACCESS_KEY")

    get("/latest",
      query: [
        access_key: "401b216f42467f0e7e15624dadb1db14",
        symbols: currency,
        format: 1
      ]
    )
  end
end
