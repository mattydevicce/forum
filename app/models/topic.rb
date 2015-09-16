class Topic < ActiveRecord::Base
  has_one :user
  validates :title, presence: true
  validates :user_id, presence: true
end
