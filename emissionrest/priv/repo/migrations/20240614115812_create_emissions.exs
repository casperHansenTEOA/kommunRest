defmodule Emissionrest.Repo.Migrations.CreateEmissions do
  use Ecto.Migration

  def change do
    create table(:emissions) do
      add :county, :string
      add :muni, :string
      add :year, :integer
      add :val, :float
      add :etype, :string

      timestamps(type: :utc_datetime)
    end
  end
end
