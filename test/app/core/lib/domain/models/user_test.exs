defmodule Core.Domain.Models.UserTest do
  use Core.DataCase

  alias Core.Domain.Models.User

  describe "changeset/2" do
    setup do
      params = %{
        name: "Bruno Ribeiro"
      }

      %{params: params}
    end

    test "returns a valid changeset if all params are valid", %{params: params} do
      assert %Ecto.Changeset{valid?: true} = User.changeset(params)
    end

    test "returns an invalid changeset if name is missing" do
      assert %Ecto.Changeset{valid?: false} = User.changeset(%{})
    end
  end
end
