defmodule EmissionrestWeb.DefaultController do
  use EmissionrestWeb, :controller
  def index(conn, _params) do
    text conn, "Live - #{Mix.env()}"
  end
end
