defmodule Core.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table("transactions", primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:origin_value, :float)
      add(:origin_currency, :string)
      add(:final_currency, :string)
      add(:convertion_tax, :float)
      add(:user_id, references("users", type: :binary_id))

      timestamps(type: :utc_datetime_usec)
    end
  end
end
