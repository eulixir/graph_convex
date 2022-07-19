defmodule Core.Domain.Transaction.Repository do
  @moduledoc """
  Repository module for Transaction
  """

  import Ecto.Query
  alias Core.Domain.Models.Transaction, as: TransactionModel
  alias Core.Domain.Transaction.Query
  alias Core.Repo

  @spec list_by_user_id(user_id :: Ecto.UUID.t()) :: transactions :: list(TransactionModel.t())
  def list_by_user_id(user_id) do
    from(tn in TransactionModel, as: :transaction, select: tn)
    |> Query.by_user_id(user_id)
    |> Repo.all()
    |> Repo.preload(:user)
  end
end
