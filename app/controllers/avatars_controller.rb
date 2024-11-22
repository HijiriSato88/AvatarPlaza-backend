class AvatarsController < ApplicationController
    before_action :set_avatar

    def update_accessory
       if @avatar.update(avatar_params)
            render json: { message: "success to update accessory", avatar: @avatar  }, status: :ok
       else
            render json: { message: "failed to update accessory", details: @avatar.errors.full_message}, status: :unprocessable_entity
       end
    end

    def update_comment
        if @avatar.update(comment: params[:comment])
            render json: { message: "success to update comment", avatar: @avatar  }, status: :ok
        else
            render json: { message: "failed to update comment", details: @avatar.errors.full_message}, status: :unprocessable_entity
        end
    end

    private
    def set_avatar
        @user = User.find(params[:id])
        @avatar = @user.avatar
    end

    def avatar_params
        params.require(:avatar).permit(:accessory_body, :accessory_head, :accessory_leg)
    end
end