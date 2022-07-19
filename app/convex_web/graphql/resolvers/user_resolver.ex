defmodule Graphql.Resolvers.User do
  alias Core.User.Services.GetUser

  def get_user(args, _banana), do: GetUser.execute(args.id)
end
