defmodule Core.Factories.User do
  @moduledoc false

  use ExMachina.Ecto, repo: Core.Repo

  alias Core.Domain.Models.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          id: Ecto.UUID.generate(),
          name: "Bruno Ribeiro"
        }
      end
    end
  end
end
