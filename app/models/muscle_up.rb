class MuscleUp < ActiveRecord::Base
  belongs_to :comment
  belongs_to :topic
end
