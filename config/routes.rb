Rails.application.routes.draw do
  root "home#index"

  get  "/login",  to: "sessions#new"
  post "/login",  to: "sessions#create"
  get  "/duo-callback", to: "sessions#duo_callback"
  get  "/logout", to: "sessions#destroy"
end
