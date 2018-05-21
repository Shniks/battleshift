Rails.application.routes.draw do

  root 'welcome#index'

  draw :authentication
  draw :users
  draw :api
  # need to do the post '/register' to 'sessions#create'
  # need to have a delete 'logout' to 'sessions#destroy'
end
