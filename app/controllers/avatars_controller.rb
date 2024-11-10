class AvatarsController < ApplicationController
    before_action :set_avatar

    def update_accessory
        
    end

    def update_comment
        
    end

    private
    def set_avatar
        @user = User.find(params[:id])
        @avatar = @user.avatar
    end

    def avatar_params
        #commentカラム追加しだい、ここも変更
        params.require(:avatar).permit(:accessory)
    end
end
