class User < ApplicationRecord
    has_many :articles, dependent: :destroy #this dependent: : destroy means if that user is deleted then all articles associated with him also get deleted
    before_save { self.email = email.downcase }

    validates :username, 
              presence: true, 
              uniqueness: { case_sensitive: false }, 
              length: { minimum: 3, maximum: 25 }

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, 
              presence: true, 
              length: { maximum: 50 },
              uniqueness: { case_sensitive: false }, 
              format: { with: VALID_EMAIL_REGEX }

has_secure_password
end