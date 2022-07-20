defmodule Core.User.Services.GetUserTest do
  use Core.DataCase

  alias Core.Domain.Models.User
  alias Core.User.Services.GetUser

  describe "execute/1" do
    setup do
      %{id: user_id} = insert(:user)

      %{user_id: user_id}
    end

    test "returns an user if was successfully fetched", %{user_id: user_id} do
      assert {:ok, %User{}} = GetUser.execute(user_id)
    end

    test "returns an error if couldn't cast parameter as UUID" do
      assert {:error, :not_found} = GetUser.execute("banana")
    end

    test "returns an error if user was not found" do
      assert {:error, :not_found} = GetUser.execute(Ecto.UUID.generate())
    end
  end
end
