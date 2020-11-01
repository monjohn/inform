defmodule Inform.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :phone, :string

    field :region, Ecto.Enum, values: [:east, :south, :triad, :triangle, :west]
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :phone, :region])
    |> validate_required([:first_name, :last_name])
  end
end
