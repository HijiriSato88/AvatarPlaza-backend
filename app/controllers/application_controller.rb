class ApplicationController < ActionController::API
    include ActionController::Cookies # Cookieを使用するために必要

    def log_in(user)

        #ログイン状態をtrueに変更
        #現時点ではまだ参加していないためtrueにしない方が望ましい
        #user.update(logged_in: true)
        
        #ログイン状態を保持
        session[:user_id] = user.id
    end

    def current_user

        #もしログインしている状態なら
        if session[:user_id]

            #データベースから該当するユーザ情報を取得
            #||=は@current_userが未定義またはuilの場合のみユーザー検索を行う
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?

        #current_userがヌルじゃないならばtrueを返す
        !current_user.nil?
    end

    def log_out

        #current_userがtrueなら
        if current_user

            #テーブル内のlogged_inカラムをfaluseにする
            #unity上で退出しないままページを閉じた場合を想定してつけておく
            current_user.avatar.update(logged_in: false)

            #保存しておいたログイン状態を破棄
            session.delete(:user_id)
            @current_user = nil
        end
    end
end
