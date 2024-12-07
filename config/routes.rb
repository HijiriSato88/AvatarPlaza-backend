Rails.application.routes.draw do

  #新規登録、一覧取得
  resources :users, only: [:index,:create]

  #ユーザのログイン、ログアウト
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/show', to: 'sessions#me'

  #アバターの情報更新
  patch '/avatar/login', to: 'avatars#avatar_login'
  patch '/avatar/logout', to: 'avatars#avatar_logout'
  patch '/avatar/accessory/update', to: 'avatars#update_accessory_me'
  patch '/avatar/comment/update', to: 'avatars#update_comment_me'

  #パスワードリセット用
  post '/password_resets', to: 'password_resets#create'
  put '/password_resets', to: 'password_resets#update'
end
