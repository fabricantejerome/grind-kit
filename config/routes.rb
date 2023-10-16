Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  # root "articles#index"

  get "categories", to: "categories#index"
  get "category/add", to: "categories#add"
  get "category/edit", to: "categories#edit"
  patch "category/edit", to: "categories#update", as: :category_update
  post "category/add", to: "categories#create"
  delete "categories", to: "categories#destroy"

  get "items", to: "items#index"
  get "item/add", to: "items#add"
  post "item/add", to: "items#create"
  get "item/edit", to: "items#edit"
  patch "item/edit", to: "items#update", as: :item_update
  delete "items", to: "items#destroy"

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "password", to: "passwords#edit", as: :edit_password
  patch "password", to: "passwords#update"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"
  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  get "blank", to: "welcome#blank"

  root to: "welcome#index"
end
