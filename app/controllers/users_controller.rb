class UsersController < ApplicationController
    #ここに呼び出されたらログインしている人を確認して、ログインしていたらその人のデータをjsonで取得するプログラムを書く
    #今回はUser,Avaterテーブルがあるので、ログインしているAvaterの情報と共通しているカラムを利用してユーザー情報を取得する
    #情報は二つのテーブル両方の全部のデータを取得する
    def index
        #@logged_in_users = User.joins(:avatar).where(avatars: { logged_in: true })
        #render json: @logged_in_users
    end
end