defmodule Graphql.Schemas.Currency do
  use Absinthe.Schema.Notation

  alias Graphql.Resolvers.Currency

  object :currency do
    field(:origin_value, :string)
    field(:final_currency, :string)
    field(:converted_value, :string)
    field(:convertion_tax, :string)
    field(:user_id, :uuid4)
    field(:transaction, :transaction)
  end

  object :currency_queries do
    field :currency, type: :currency do
      arg(:value, non_null(:float))
      arg(:final_currency, non_null(:string))
      arg(:user_id, non_null(:uuid4))

      resolve(&Currency.convert/2)
    end
  end
end
