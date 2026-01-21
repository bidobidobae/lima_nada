class Salary < ApplicationRecord
  belongs_to :user
  has_one :bookkeeping, dependent: :destroy

  enum salary_type: { fixed: 0, per_attendance: 1 }
  enum status: { pending: 0, paid: 1 }

  validates :amount, :month, :year, presence: true
  validates :user_id, uniqueness: { scope: [:month, :year], message: "sudah memiliki gaji untuk bulan ini" }

  after_create :create_bookkeeping_if_paid
  after_update :sync_bookeeping_if_paid

  def total_amount
    return amount if fixed?

    attendance_count = user.attendances.where("extract(month from meeting_date) = ? AND extract(year from meeting_date) = ?", month, year).count

    amount * attendance_count
  end

  private

  def create_bookkeeping_if_paid
    return unless paid?

    create_bookkeeping(
      date: created_at,
      amount: total_amount,
      status: :keluar,
      category: :salary,
      user: user,
      description: "salary #{user.name} bulan #{month}",
      salary: self
    )
  end
end
