defmodule EmissionrestWeb.Router do
  use EmissionrestWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EmissionrestWeb do
    pipe_through :api
    get "/", DefaultController, :index
    post "/emissions", EmissionController, :create
    get "/emissions", EmissionController, :index
    get "/emissions/:id", EmissionController, :show
    put "/emissions/:id", EmissionController, :update
    delete "/emissions/:id", EmissionController, :delete

  end



  # Enable LiveDashboard in development
  if Application.compile_env(:emissionrest, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: EmissionrestWeb.Telemetry
    end
  end
end
