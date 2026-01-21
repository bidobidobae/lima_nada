class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 0,
               teacher: 1,
               staff: 2,
               volunteer: 3
             }

  has_many :invoices
  has_many :salaries
  has_many :bookkeepings
  has_many :attendances

  def attendance_count_for(month, year)
    Attendance.where(user_id: id).where("extract(month from meeting_date) = ? AND extract(year from meeting_date) = ?", month, year).count
  end
end
