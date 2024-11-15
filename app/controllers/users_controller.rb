class UsersController < ApplicationController
    def index
        #includesを使ってuser,avatarをくっつける。その中でlogged_inがtrueのやつをフィルタリングする。
        @logged_in_users = User.includes(:avatar).where(avatars: { logged_in: true })
        # includes を使って関連する Avatar データを一緒に取得。
        render json: @logged_in_users,status: :ok
    end
end