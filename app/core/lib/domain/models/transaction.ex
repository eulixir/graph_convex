defmodule Core.Domain.Models.Transaction do
  @moduledoc """
  Schema for a Transaction
  """

  use Core.Schema
  alias Core.Domain.Models.User

  @required ~w(origin_value origin_currency final_currency convertion_tax user_id)a

  @optional ~w()a

  schema "transactions" do
    field(:origin_value, :float)
    field(:origin_currency, :string)
    field(:final_currency, :string)
    field(:convertion_tax, :float)

    belongs_to(:user, User)

    timestamps()
  end

  @spec changeset(schema :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(schema \\ %__MODULE__{}, params) do
    schema
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
