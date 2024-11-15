class UsersController < ApplicationController
  
    def index
        #includesを使ってuser,avatarをくっつける。その中でlogged_inがtrueのやつをフィルタリングする。
        @logged_in_users = User.includes(:avatar).where(avatars: { logged_in: true })
        # includes を使って関連する Avatar データを一緒に取得。
        render json: @logged_in_users.to_json(include: :avatar), status: :ok
    end

    #ユーザーの新規登録を行う
    def create
        #新しいuserオブジェクトをuser_paramsで初期化している。
        user = User.new(user_params)
        #user.saveでUserモデルの保存を試みて成功したら登録完了処理、そうでなければエラー処理を行う。
        if user.save
            render json:{message: "ユーザー登録が完了しました。",user: user },states: :created
        else
            render json:{errors: user.errors.full_messages }, status: unprocessable_entity
        end
    end
    #ユーザーの削除を行う。
    def destroy
        #リクエストのパラメータからstudent_idを取得し、それに基づいて対象のユーザーを検索している。
        user = User.find_by(id: params[:student_id])
        #userが存在し、user.destroyによってアカウントの削除が成された場合削除処理をそうでない場合、エラー処理を行う。
        if user && user.destroy
            render json: {message:"アカウントが削除されました。"},status: :ok
        else
            render json: {error:"アカウントの削除に失敗しました。"},status: :not_found
        end
    end
    #privateによってuser_paramsはこのコントローラー内でしか使用できない。
    private

    #params.require(:user)ではパラメータからuserというキーのデータが必須であることを指定している。
    #permit()内は指定した属性のみを許可し、その他のデータは許可しないようになっている。
    def user_params
        params.require(:user).permit(name:,student_id:,email:,password_digest:)#登録するための要素を追加
    end
end
