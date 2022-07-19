defmodule Graphql.Schemas.User do
  use Absinthe.Schema.Notation

  alias Graphql.Resolvers.User

  object :user do
    field(:id, :uuid4)
    field(:name, :string)
  end

  object :users_queries do
    field :user, type: :user do
      arg(:id, non_null(:uuid4))
      resolve(&User.get_user/2)
    end
  end
end
