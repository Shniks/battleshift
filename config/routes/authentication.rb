get '/login',     to: 'sessions#new'
post '/login',    to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'
