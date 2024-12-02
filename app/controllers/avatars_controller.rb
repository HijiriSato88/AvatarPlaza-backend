class AvatarsController < ApplicationController
    before_action :authenticate_user
    before_action :set_avatar, only: [:avatar_login, :avatar_logout, :update_comment_me, :update_accessory_me]

    def avatar_login
        if @avatar.update(logged_in: true)
            render json: { update: true }, status: :ok
        else
            render json: { success: false, message: 'Failed to update logged_in', errors: @avatar.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def avatar_logout
        if @avatar.update(logged_in: false)
            render json: { update: true }, status: :ok
        else
            render json: { success: false, message: 'Failed to update logged_out', errors: @avatar.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update_comment_me
        if @avatar.update(comment: params[:comment])
            render json: { success: true, message: "Successfully updated comment", avatar: @avatar }, status: :ok
        else
            render json: { success: false, message: "Failed to update comment", errors: @avatar.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update_accessory_me
        if @avatar.update(avatar_params)
            render json: { success: true, message: "Successfully updated accessory", avatar: @avatar }, status: :ok
        else
            render json: { success: false, message: "Failed to update accessory", errors: @avatar.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def authenticate_user
        unless logged_in?
            render json: { success: false, message: "ログインしていません。" }, status: :unauthorized
        end
    end

    def set_avatar
        @avatar = current_user.avatar
        unless @avatar
            render json: { success: false, message: "Avatar not found." }, status: :not_found
        end
    end

    def avatar_params
        params.require(:avatar).permit(:accessory_body, :accessory_head, :accessory_leg)
    end
end