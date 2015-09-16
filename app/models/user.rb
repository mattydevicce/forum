class User < ActiveRecord::Base
  has_many :comments
  has_secure_password
  validates :username, uniqueness: true
  validates :username, :email, :password, :password_confirmation, presence: true
  validate :password_match, :password, :password_confirmation

  def password_match
    if password != password_confirmation
      errors.add(:user_id, "password fields must match")
    end
  end
end
