  
namespace :api do
  namespace :v1 do
    post '/games', to: 'games#create'
    resources :games, only: [:show] do
      post '/ships', to: 'games/ships#index'
      post '/shots', to: 'games/shots#create'
    end
  end
end
