defmodule Graphql.Schemas.Transaction do
  use Absinthe.Schema.Notation

  alias Graphql.Resolvers.Transactions

  object :transaction do
    field(:origin_value, :string)
    field(:origin_currency, :string)
    field(:final_currency, :string)
    field(:convertion_tax, :float)
    field(:user, :user)
    field(:id, :uuid4)
  end

  object :transaction_queries do
    field :transaction, type: list_of(:transaction) do
      arg(:user_id, non_null(:uuid4))

      resolve(&Transactions.list_transactions/2)
    end
  end
end
