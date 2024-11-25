Rails.application.routes.draw do
  resources :users, only: [:index,:create,:new]
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/show', to: 'sessions#me'

  #アバターの情報更新
  patch '/users/:id/avatar/accessory', to: 'avatars#update_accessory'
  patch '/users/:id/avatar/comment', to: 'avatars#update_comment'
  patch '/users/:id/avatar/login', to: 'avatars#avatar_login'
  patch '/users/:id/avatar/logout', to: 'avatars#avatar_logout'

  #get "up" => "rails/health#show", as: :rails_health_check
end
