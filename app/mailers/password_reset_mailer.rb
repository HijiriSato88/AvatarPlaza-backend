class PasswordResetMailer < ApplicationMailer
    def password_reset(user)
        @user = user
        @reset_url = "http://localhost:5173/reset-password?token=#{@user.reset_password_token}"
    
        mail(to: @user.email, subject: "Password Reset Instructions")
    end
end
