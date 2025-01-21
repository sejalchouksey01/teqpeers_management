class Course < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :users, through: :enrollments
  has_many :feedbacks, dependent: :destroy
  has_many :subtopics, dependent: :destroy
end
