defmodule EmissionrestWeb.EmissionControllerTest do
  use EmissionrestWeb.ConnCase

  import Emissionrest.EmissionsFixtures

  alias Emissionrest.Emissions.Emission

  @create_attrs %{
    year: 42,
    val: 120.5,
    county: "some county",
    muni: "some muni",
    etype: "some etype"
  }
  @update_attrs %{
    year: 43,
    val: 456.7,
    county: "some updated county",
    muni: "some updated muni",
    etype: "some updated etype"
  }
  @invalid_attrs %{year: nil, val: nil, county: nil, muni: nil, etype: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all emissions", %{conn: conn} do
      conn = get(conn, ~p"/api/emissions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create emission" do
    test "renders emission when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/emissions", emission: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/emissions/#{id}")

      assert %{
               "id" => ^id,
               "county" => "some county",
               "etype" => "some etype",
               "muni" => "some muni",
               "val" => 120.5,
               "year" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/emissions", emission: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update emission" do
    setup [:create_emission]

    test "renders emission when data is valid", %{conn: conn, emission: %Emission{id: id} = emission} do
      conn = put(conn, ~p"/api/emissions/#{emission}", emission: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/emissions/#{id}")

      assert %{
               "id" => ^id,
               "county" => "some updated county",
               "etype" => "some updated etype",
               "muni" => "some updated muni",
               "val" => 456.7,
               "year" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, emission: emission} do
      conn = put(conn, ~p"/api/emissions/#{emission}", emission: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete emission" do
    setup [:create_emission]

    test "deletes chosen emission", %{conn: conn, emission: emission} do
      conn = delete(conn, ~p"/api/emissions/#{emission}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/emissions/#{emission}")
      end
    end
  end

  defp create_emission(_) do
    emission = emission_fixture()
    %{emission: emission}
  end
end
