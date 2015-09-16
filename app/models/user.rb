class User < ActiveRecord::Base
  has_many :comments
  has_secure_password
  validates :username, uniqueness: true
  validates :username, :email, :password, :password_confirmation, presence: true
end