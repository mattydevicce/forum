class Topic < ActiveRecord::Base
  has_one :user
  has_one :category
  has_many :comments
  validates :title, presence: true
  validates :user_id, presence: { message: "You need to be logged in to create a topic" }
  validates :category_id, presence: { message: "Choose a subject" }
end
