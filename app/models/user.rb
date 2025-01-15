class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # has_many :feedbacks, dependent_destroy
  has_many :enrollments
  has_many :courses, through: :enrollments

  has_many :feedbacks_given, class_name: 'Feedback', foreign_key: 'user_given_id'
  has_many :feedbacks_received, class_name: 'Feedback', foreign_key: 'user_received_id'

  has_many :received_courses, through: :feedbacks_received, source: :course

  def name
    "#{first_name} #{last_name}"
  end
end
