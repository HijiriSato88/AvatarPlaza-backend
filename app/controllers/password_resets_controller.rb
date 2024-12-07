class PasswordResetsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user
            # 一時トークンの生成と保存
            user.reset_password_token = SecureRandom.urlsafe_base64
            user.reset_password_sent_at = Time.current
            user.save
            # 再設定メール送信
            PasswordResetMailer.password_reset(user).deliver_now
            render json: { message: 'パスワードリセットメールを送信しました。' }, status: :ok
        else
            render json: { error: 'メールアドレスが見つかりませんでした。' }, status: :not_found
        end
    end

    def update
        user = User.find_by(reset_password_token: params[:token])
    
        if user && user.reset_password_sent_at > 2.hours.ago # トークンの有効期限を確認
            if user.update(password: params[:password])
                # トークンを無効化
                user.update(reset_password_token: nil, reset_password_sent_at: nil)
                render json: { message: "Password successfully updated." }
            else
                render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { error: "Invalid or expired token." }, status: :unprocessable_entity
        end
    end
end
