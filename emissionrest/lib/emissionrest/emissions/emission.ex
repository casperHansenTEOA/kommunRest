defmodule Emissionrest.Emissions.Emission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emissions" do
    field :year, :integer
    field :val, :float
    field :county, :string
    field :muni, :string
    field :etype, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(emission, attrs) do
    emission
    |> cast(attrs, [:county, :muni, :year, :val, :etype])
    |> validate_required([:county, :muni, :year, :val, :etype])
  end
end
