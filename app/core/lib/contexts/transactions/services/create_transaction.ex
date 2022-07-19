defmodule Core.Transaction.Services.CreateTransaction do
  @moduledoc """
  Service to create a Transaction
  """

  alias Core.Domain.Models.Transaction
  alias Core.Transaction.Commands.CreateTransaction

  @spec execute(transaction :: CreateTransaction.t()) :: map()
  def execute(%CreateTransaction{} = create_transaction) do
    %{
      origin_value: create_transaction.value,
      origin_currency: create_transaction.origin_currency,
      final_currency: create_transaction.final_currency,
      convertion_tax: create_transaction.convertion_tax,
      user_id: create_transaction.user_id
    }
    |> Transaction.changeset()
    |> Core.Repo.insert!()
  end
end
