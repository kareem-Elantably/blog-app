Rails.application.routes.draw do
  # Devise routes for user authentication
  devise_for :users, controllers: { sessions: 'sessions' }, skip: [:registrations]

  # Routes for user registration and CRUD operations on posts
  resources :users, only: [:create]
  resources :posts do
    resources :comments
  end

  # Other routes...

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Optional: Define the root path route ("/")
  # root "posts#index"
end
