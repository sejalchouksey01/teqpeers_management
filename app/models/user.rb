class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, [ :trainee, :mentor, :manager ]

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :enrollments
  has_many :courses, through: :enrollments

  has_many :feedbacks_given, class_name: 'Feedback', foreign_key: 'mentor_id'
  has_many :feedbacks_received, class_name: 'Feedback', foreign_key: 'trainee_id'

  has_many :received_courses, through: :feedbacks_received, source: :course
  has_many :attendances
  has_many :statuses, class_name: 'DailyStatus', foreign_key: 'user_id'
  def name
    "#{first_name} #{last_name}"
  end

end
