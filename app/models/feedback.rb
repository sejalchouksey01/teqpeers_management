class Feedback < ApplicationRecord
  belongs_to :mentor, class_name: 'User', foreign_key: 'mentor_id'
  belongs_to :trainee, class_name: 'User', foreign_key: 'trainee_id'
  belongs_to :course
  belongs_to :subtopic, optional: true
  validates :detail, presence: true

  validates :trainee_id, uniqueness: { 
    scope: [:course_id, :subtopic_id], 
    message: "can only provide one feedback per course and subtopic"
  }
end
