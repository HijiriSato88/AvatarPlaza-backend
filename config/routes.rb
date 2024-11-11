Rails.application.routes.draw do
  #ログイン
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  #ユーザ
  resources :users, only: [:index,:create,:new]

  #アバターの情報更新
  patch '/users/:id/avatar/accessory', to: 'avatars#update_accessory'
  patch '/users/:id/avatar/comment', to: 'avatars#update_comment'

  #get "up" => "rails/health#show", as: :rails_health_check
end
