class Course < ApplicationRecord
  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :feedbacks
end
