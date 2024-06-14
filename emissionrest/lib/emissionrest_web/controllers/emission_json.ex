defmodule EmissionrestWeb.EmissionJSON do
  alias Emissionrest.Emissions.Emission

  @doc """
  Renders a list of emissions.
  """
  def index(%{emissions: emissions}) do
    %{data: for(emission <- emissions, do: data(emission))}
  end

  @doc """
  Renders a single emission.
  """
  def show(%{emission: emission}) do
    %{data: data(emission)}
  end

  defp data(%Emission{} = emission) do
    %{
      id: emission.id,
      county: emission.county,
      muni: emission.muni,
      year: emission.year,
      val: emission.val,
      etype: emission.etype
    }
  end
end
