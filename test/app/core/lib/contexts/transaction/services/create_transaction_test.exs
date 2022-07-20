defmodule Core.Transaction.Services.CreateTransactionTest do
  use Core.DataCase

  alias Core.Domain.Models.Transaction
  alias Core.Transaction.Commands
  alias Core.Transaction.Services

  describe "execute/1" do
    setup do
      %{id: user_id} = insert(:user)

      params = %Commands.CreateTransaction{
        value: 1000,
        origin_currency: "BRL",
        final_currency: "USD",
        convertion_tax: 6.33,
        user_id: user_id
      }

      %{params: params}
    end

    test "inserts and return Transaction schema if successfull", %{params: params} do
      assert %Transaction{id: transaction_id} = Services.CreateTransaction.execute(params)

      assert %Transaction{} = Core.Repo.get(Transaction, transaction_id)
    end
  end
end
