Rails.application.routes.draw do
  resources :users, only: [:index,:create,:new]
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/show', to: 'sessions#me'

  #アバターの情報更新
  patch '/avatar/login', to: 'avatars#avatar_login'
  patch '/avatar/logout', to: 'avatars#avatar_logout'
  patch '/avatar/accessory/update', to: 'avatars#update_accessory_me'
  patch '/avatar/comment/update', to: 'avatars#update_comment_me'
end
