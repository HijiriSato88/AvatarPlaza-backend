class User < ApplicationRecord
    belongs_to :avatar
    has_secure_password
end
