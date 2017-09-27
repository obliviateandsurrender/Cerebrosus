class User < ApplicationRecord
    # Things not needed.
    attr_accessor :password_confirmation
    has_secure_password
    validates :name, presence: true
    validates :username, presence: true
    validates :email, presence: true, email: true
    validates :password, presence: true, length: {:within => 8..40}
end