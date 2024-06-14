defmodule EmissionrestWeb.EmissionController do
  use EmissionrestWeb, :controller

  alias Emissionrest.Emissions
  alias Emissionrest.Emissions.Emission

  action_fallback EmissionrestWeb.FallbackController

  def index(conn, _params) do
    emissions = Emissions.list_emissions()
    render(conn, :index, emissions: emissions)
  end

  def create(conn, %{"emission" => emission_params}) do
    with {:ok, %Emission{} = emission} <- Emissions.create_emission(emission_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/emissions/#{emission}")
      |> render(:show, emission: emission)
    end
  end

  def show(conn, %{"id" => id}) do
    emission = Emissions.get_emission!(id)
    render(conn, :show, emission: emission)
  end

  def update(conn, %{"id" => id, "emission" => emission_params}) do
    emission = Emissions.get_emission!(id)

    with {:ok, %Emission{} = emission} <- Emissions.update_emission(emission, emission_params) do
      render(conn, :show, emission: emission)
    end
  end

  def delete(conn, %{"id" => id}) do
    emission = Emissions.get_emission!(id)

    with {:ok, %Emission{}} <- Emissions.delete_emission(emission) do
      send_resp(conn, :no_content, "")
    end
  end
end
