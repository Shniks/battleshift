namespace :users do
  get '/activation', to: 'activation#update'
end

resources :users, only: [:create]
get '/register',  to: 'users#new'
post '/register', to: 'users#create'
get '/dashboard', to: 'users#show'
