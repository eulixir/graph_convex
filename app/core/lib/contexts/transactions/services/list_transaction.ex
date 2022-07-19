defmodule Core.Transaction.Services.ListTransactions do
  @moduledoc """
  Service to list Transactions by user_id
  """

  alias Core.Domain.Transaction.Repository
  alias Ecto.UUID

  @doc """
  Returns a list of `transactions` belongs to the user of `user_id`
  """
  @spec execute(user_id :: UUID.t()) :: list(Schemas.Transaction.t())
  def execute(user_id) do
    with {:ok, _} <- cast_user_id(user_id) do
      Repository.list_by_user_id(user_id)
    end
  end

  defp cast_user_id(user_id) do
    with :error <- UUID.cast(user_id) do
      []
    end
  end
end
