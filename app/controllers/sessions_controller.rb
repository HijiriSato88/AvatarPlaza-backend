class SessionsController < ApplicationController
    
    #ログイン
    def create
        #student_idがDBにあるものと一致するなら、そのUserを取得
        user = User.find_by(student_id: params[:student_id].downcase)

        #userがtrueかつpasswordがuserのものと一致するなら
        if user && user.authenticate(params[:password])
            #log_inメソッド呼び出し(application_controller内に定義)
            log_in user
            render json: { message: "ログインが成功しました。", user: user }, status: :ok
        else
            #表示
            render json: { message: "パスワードが無効です。" }, status: :unauthorized
        end
    end

    #ログアウト
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

    def me
        if logged_in?
            user = current_user
            avatar = user.avatar
        
            fields = params[:fields]&.split(',')&.map(&:to_sym)

            user_data = {
                id: user.id,
                name: user.name,
                student_id: user.student_id,
                accessory_head: avatar&.accessory_head,
                accessory_body: avatar&.accessory_body,
                accessory_leg: avatar&.accessory_leg,
                logged_in: avatar&.logged_in,
                comment: avatar&.comment
            }
        
            if fields.present?
                user_data = user_data.slice(*fields)
            end
        
            render json: { user: user_data }, status: :ok
        else
            render json: { message: "ログインしていません。" }, status: :unauthorized
        end
    end
end