defmodule Emissionrest.Emissions do
  @moduledoc """
  The Emissions context.
  """

  import Ecto.Query, warn: false
  alias Emissionrest.Repo

  alias Emissionrest.Emissions.Emission

  @doc """
  Returns the list of emissions.

  ## Examples

      iex> list_emissions()
      [%Emission{}, ...]

  """
  def list_emissions do
    Repo.all(Emission)
  end

  @doc """
  Gets a single emission.

  Raises `Ecto.NoResultsError` if the Emission does not exist.

  ## Examples

      iex> get_emission!(123)
      %Emission{}

      iex> get_emission!(456)
      ** (Ecto.NoResultsError)

  """
  def get_emission!(id), do: Repo.get!(Emission, id)

  @doc """
  Creates a emission.

  ## Examples

      iex> create_emission(%{field: value})
      {:ok, %Emission{}}

      iex> create_emission(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_emission(attrs \\ %{}) do

    %Emission{}
    |> Emission.changeset(attrs)
    |> Repo.insert()
  end

  defp type_validate_attrs(attrs) do
    attrs.val = String.to_float(attrs.val)
    attrs.year = String.to_integer(attrs.year)
    attrs
  end

  @doc """
  Updates a emission.

  ## Examples

      iex> update_emission(emission, %{field: new_value})
      {:ok, %Emission{}}

      iex> update_emission(emission, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_emission(%Emission{} = emission, attrs) do
    emission
    |> Emission.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a emission.

  ## Examples

      iex> delete_emission(emission)
      {:ok, %Emission{}}

      iex> delete_emission(emission)
      {:error, %Ecto.Changeset{}}

  """
  def delete_emission(%Emission{} = emission) do
    Repo.delete(emission)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking emission changes.

  ## Examples

      iex> change_emission(emission)
      %Ecto.Changeset{data: %Emission{}}

  """
  def change_emission(%Emission{} = emission, attrs \\ %{}) do
    Emission.changeset(emission, attrs)
  end
end
