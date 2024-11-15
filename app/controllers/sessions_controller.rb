class SessionsController < ApplicationController
   #ログイン時 
   def create

        #emailがデータベース上にあるものと一致するならuserにUserテーブルを格納
        user = User.find_by(email: params[:email].downcase)

        #userがtrueかつpasswordがuserのものと一致するなら
        if user && user.authenticate(params[:password])

            #log_inメソッド呼び出し(application_controller内に定義)
            log_in user

            #表示
            render json: { message: "ログインが成功しました。", user: user }, status: :ok

        else

            #表示
            render json: { message: "e-mailまたはパスワードが無効です。" }, status: :unauthorized

        end
    end

    #ログアウト時
    def destroy

        #このメソッドがtrueなら(application_controller内に定義)
        if logged_in?
            
            #ログアウトするユーザーを保存
            user = current_user

            #log_outメソッド呼び出し(application_controller内に定義)
            log_out

            #表示
            render json: { message: "ログアウトが成功しました。", user: user }, status: :ok

        else

            #表示
            render json: { message: "ログアウトするユーザーがいません。" }, status: :unauthorized

        end
    end
end