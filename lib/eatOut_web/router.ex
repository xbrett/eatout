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

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EatOutWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/home", PageController, :home
    resources "/users", UserController
    resources "/reviews", ReviewController
    resources "/chats", ChatController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
    resources "/friends", FriendController

  end

  # Other scopes may use custom stacks.
  # scope "/api", EatOutWeb do
  #   pipe_through :api
  # end
end
