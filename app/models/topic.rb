class Topic < ActiveRecord::Base
  has_one :user
  validates :title, presence: true
  validates :user_id, presence: { message: "You need to be logged in to create a topic" }
end
