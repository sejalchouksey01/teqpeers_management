class Subtopic < ApplicationRecord
  belongs_to :course
  has_many :feedbacks, dependent: :destroy
end
