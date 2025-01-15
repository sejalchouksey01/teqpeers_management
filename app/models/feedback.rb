class Feedback < ApplicationRecord
  belongs_to :user_given, class_name: 'User', foreign_key: 'user_given_id'
  belongs_to :user_received, class_name: 'User', foreign_key: 'user_received_id'
  belongs_to :course

  validates :detail, presence: true
end
