defmodule Emissionrest.EmissionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Emissionrest.Emissions` context.
  """

  @doc """
  Generate a emission.
  """
  def emission_fixture(attrs \\ %{}) do
    {:ok, emission} =
      attrs
      |> Enum.into(%{
        Emission type: "some Emission type",
        Kommun: "some Kommun",
        Län: "some Län",
        Value: 120.5,
        År: 42
      })
      |> Emissionrest.Emissions.create_emission()

    emission
  end

  @doc """
  Generate a emission.
  """
  def emission_fixture(attrs \\ %{}) do
    {:ok, emission} =
      attrs
      |> Enum.into(%{
        county: "some county",
        etype: "some etype",
        muni: "some muni",
        val: 120.5,
        year: 42
      })
      |> Emissionrest.Emissions.create_emission()

    emission
  end
end
