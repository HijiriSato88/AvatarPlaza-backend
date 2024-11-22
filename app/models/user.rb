class User < ApplicationRecord
    belongs_to :avatar
    has_secure_password

    #名前のバリデーション,ひらがな、かたかな、漢字、アルファベットのみ認める。
    validates:name,presence:true,format:{with:/\A[ぁ-んァ-ヶ一-龠々ーa-zA-Z]+\z/}

    #学籍番号のバリデーション,学籍番号の途中にRD,RMDの文字列がないといけない。それより前は2文字の数列、後は3文字の数列でないといけない。
    validates:student_id,presence:true,format:{with:/\A\d{2}(RD)\d{3}\z/}
    
    #メールアドレスのバリデーション,アドレス中の大文字小文字は区別している。
    validates:email,presence:true, uniqueness: { case_sensitive: true }
    
    #パスワードのバリデーション,文字列の長さは6文字以上20文字以下でなければならない。
    validates:password_digest,presence:true,length:{in:6..20}
    
end
