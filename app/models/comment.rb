class Comment < ActiveRecord::Base
  has_one :user
  has_one :topic
  validates :user_id, :content, presence: true
end
