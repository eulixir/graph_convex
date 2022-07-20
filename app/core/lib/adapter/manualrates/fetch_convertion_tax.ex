defmodule Core.Adapters.FetchConvertionTax.ManualRates do
  @moduledoc """
  Adapters for ManualRates implements FetchConvertionTax
  """

  @behaviour Core.Ports.FetchConvertionTax

  @impl true
  def fetch_convertion_tax(_currency) do
    {:ok, 5.30}
  end
end
