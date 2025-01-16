class Feedback < ApplicationRecord
  belongs_to :mentor, class_name: 'User', foreign_key: 'mentor_id'
  belongs_to :trainee, class_name: 'User', foreign_key: 'trainee_id'
  belongs_to :course

  validates :detail, presence: true
end
