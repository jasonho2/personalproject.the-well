Rails.application.routes.draw do
  get "admin/dashboard"
  get "members/create"
  get "members/index"
  root "pages#home"

  resources :posts, only: [ :new, :create, :destroy ]
  resources :posts

  resources :members, only: [ :create, :index ]

  get "members", to: "pages#members"  # if handled by PagesController

  get "/about-us", to: "pages#about_us", as: :about_us
  get "/about-me", to: "pages#about_me", as: :about_me
  get "/join-us", to: "pages#join_us", as: :join_us

  namespace :admin do
    get "dashboard", to: "dashboard#index"
    post "events/sync", to: "events#sync"
  end

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
