defmodule Graphql.Schema do
  use Absinthe.Schema

  alias GraphQL.Middlewares.ErrorHandler

  import_types(Graphql.Helpers.UUID4)
  import_types(Graphql.Schema.User)
  import_types(Graphql.Schema.Transaction)

  @desc "The root of query operations"
  query do
    import_fields(:users_queries)
    import_fields(:transaction_queries)
  end

  # mutation do

  # end
  def middleware(middleware, _field, _object),
    do: middleware ++ [ErrorHandler]
end
