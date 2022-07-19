defmodule Core.User.Services.GetUser do
  @moduledoc """
  Service to fetcher a user using a given user_id
  """
  alias Core.Domain.Models.User

  @spec execute(user_id :: Ecto.UUID.t()) ::
          {:ok, user :: User.t()} | {:error, :not_found}
  def execute(user_id) do
    case Ecto.UUID.cast(user_id) do
      {:ok, _uuid} ->
        fetch_user(user_id)

      :error ->
        {:error, :not_found}
    end
  end

  defp fetch_user(user_id) do
    case Core.Repo.get(User, user_id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
