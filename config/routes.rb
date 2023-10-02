Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  # root "articles#index"

  get "sign_up", to: "registrations#new"

  get "login", to: "sessions#new"

  get "blank", to: "welcome#blank"

  root to: "welcome#index"
end
