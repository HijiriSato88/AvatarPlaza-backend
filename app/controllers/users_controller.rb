class UsersController < ApplicationController
    
    def index
        #includesを使ってuser,avatarをくっつける。その中でlogged_inがtrueのやつをフィルタリングする。
        @logged_in_users = User.includes(:avatar).where(avatars: { logged_in: true })

        fields = params[:fields]&.split(',')&.map(&:to_sym)

        users = @logged_in_users.map do |user|
            user_data = {
                id: user.id,
                name: user.name,
                student_id: user.student_id,
                accessory_head: user.avatar&.accessory_head,
                accessory_body: user.avatar&.accessory_body,
                accessory_leg: user.avatar&.accessory_leg,
                logged_in: user.avatar&.logged_in,
                comment: user.avatar&.comment
            }
            if fields.present?
                user_data = user_data.slice(*fields)
            end
            user_data
        end

        render json: { users: users }, status: :ok
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

    private
    def user_params
        params.require(:user).permit(:name, :student_id, :email, :password)
    end
end
