defmodule Graphql.Resolvers.Transactions do
  alias Core.Domain.Models.User
  alias Core.User.Services.GetUser
  alias Core.Transaction.Services.ListTransactions

  def list_transactions(args, _context) do
    case GetUser.execute(args.user_id) do
      {:ok, %User{}} ->
        {:ok, ListTransactions.execute(args.user_id)}

      {:error, :not_found} ->
        {:error, "User not found"}
    end
  end
end
