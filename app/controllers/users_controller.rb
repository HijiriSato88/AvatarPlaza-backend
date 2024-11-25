class UsersController < ApplicationController
    
    def index
        #includesを使ってuser,avatarをくっつける。その中でlogged_inがtrueのやつをフィルタリングする。
        @logged_in_users = User.includes(:avatar).where(avatars: { logged_in: true })
        # includes を使って関連する Avatar データを一緒に取得。
        render json: @logged_in_users.to_json(include: :avatar), status: :ok
    end

    def create
        user = User.new(user_params)
        if user.save
            avatar = Avatar.create(user: user)
            render json: { message: "ユーザー登録が完了しました。", user: user, avatar: avatar }, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end


    #privateによってuser_paramsはこのコントローラー内でしか使用できない。
    private

    #params.require(:user)ではパラメータからuserというキーのデータが必須であることを指定している。
    #permit()内は指定した属性のみを許可し、その他のデータは許可しないようになっている。
    def user_params
        params.require(:user).permit(:name, :student_id, :email, :password)
    end
end
