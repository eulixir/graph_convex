defmodule Graphql.Resolvers.Transactions do
  alias Core.CurrencyConvertor.Commands.ConvertCurrency
  alias Core.CurrencyConvertor.Services
  alias Core.Domain.Models.{User, Transaction}
  alias Core.Transaction.Commands
  alias Core.User.Services.GetUser
  alias Core.Utils.{Changesets, Format}
  alias Core.Transaction.Services.{CreateTransaction, ListTransactions}
  # alias WebAPI.Helpers.ErrorResponses

  def convert_currency(%{"user_id" => user_id} = params, _context) do
    with {:ok, %User{}} <- GetUser.execute(user_id),
         {:ok, %ConvertCurrency{converted_value: converted_value} = convert_currency_service} <-
           call_command_service_convert_currency(params),
         %Transaction{} = transaction <-
           call_command_service_create_transaction(convert_currency_service, user_id) do
      {:ok, build_transaction_params(transaction, converted_value)}
    else
      {:error, _} ->
        # {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect("banana")
        # ErrorResponses.changeset_error(conn, changeset, 400)

        # {:error, :not_found} ->
        # ErrorResponses.not_found(conn, "user", user_id)

        # {:error, _} ->
        # ErrorResponses.server_error(conn, 503)
    end
  end

  def list_transactions(args, _context) do
    case GetUser.execute(args.id) do
      {:ok, %User{}} ->
        {:ok, ListTransactions.execute(args.id)}

      {:error, :not_found} ->
        IO.inspect("banana")
        # ErrorResponses.not_found(conn, "user", user_id)
    end
  end

  defp call_command_service_convert_currency(params) do
    with {:ok, %ConvertCurrency{} = convert_currency_command} <-
           Changesets.cast_and_apply(Commands.ConvertCurrency, params) do
      Services.ConvertCurrency.execute(convert_currency_command)
    end
  end

  defp call_command_service_create_transaction(params, user_id) do
    with {:ok, %Commands.CreateTransaction{} = create_transaction_command} <-
           Changesets.cast_and_apply(
             CreateTransaction,
             params
             |> Map.put(:user_id, user_id)
             |> Map.from_struct()
           ) do
      CreateTransaction.execute(create_transaction_command)
    end
  end

  defp build_transaction_params(transaction, converted_value) do
    transaction
    |> Map.from_struct()
    |> Map.put(:converted_value, converted_value)
    |> Map.put(
      :origin_value,
      transaction.origin_value
      |> Format.format_value_with_precision(2)
      |> Number.Currency.number_to_currency(Format.format_currency(transaction.origin_currency))
    )
  end
end
