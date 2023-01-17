Rails.application.routes.draw do
  resources :comments
  get '/posts/:id', to: 'posts#show'
  resources :posts
  get '/communities/:id', to: 'communities#show'
  resources :communities
  get '/users/communities', to: 'users#joinedCommunities'
  get '/communities', to: 'communities#index'
  get '/communities_all', to: 'communities#ComAll'

  resources :users
  get '/users/:id', to: 'users#show'
  get "/auto_login", to: "users#auto_login"
  post '/signup', to: "users#create"
  post "/login", to: "users#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
