defmodule EatOutWeb.Router do
  use EatOutWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EatOutWeb.Plugs.FetchSession

  end

  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug EatOutWeb.Plugs.FetchSession
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EatOutWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/home", LocationController, :home
    resources "/users", UserController
    resources "/reviews", ReviewController
    resources "/chats", ChatController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
<<<<<<< HEAD

  end
=======
    resources "/friends", FriendController
>>>>>>> 4c304bfa070b63355cbe1dc6c1070ab656a0e9d9

  scope "/ajax", EatOutWeb do
    pipe_through :ajax
    post "/location", LocationController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", EatOutWeb do
  #   pipe_through :api
  # end
end
