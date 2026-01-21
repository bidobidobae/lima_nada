class Invoice < ApplicationRecord
  has_many :attendances, dependent: :destroy
  belongs_to :user
  belongs_to :student
  has_one :bookkeeping, dependent: :destroy

  after_create :create_attendances
  after_create :create_bookkeeping_if_paid
  after_update :sync_bookkeeping_if_paid

  enum status: { pending: 0, paid: 1 }

  def meeting_dates
    [meeting_date_1, meeting_date_2, meeting_date_3, meeting_date_4]
  end

  private

    def create_attendances
      [meeting_date_1, meeting_date_2, meeting_date_3, meeting_date_4].each do |date|
        next if date.blank?
        attendances.create!(
          student: student,
          meeting_date: date
        )
      end
    end

    def create_bookkeeping_if_paid
      return unless paid?

      create_bookkeeping(
        date: created_at,
        amount: amount,
        status: :masuk,
        category: :iuran_kursus,
        user: user,
        description: "invoice #{student.name} bulan #{created_at}",
        invoice: self
      )
    end

    def sync_bookkeeping_if_paid
    if saved_change_to_status? && paid?
      # status berubah dari pending → paid → buat bookkeeping baru
      create_bookkeeping(
        date: updated_at,
        amount: amount,
        status: :masuk,
        category: :iuran_kursus,
        user: user,
        description: "invoice #{student.name} bulan #{created_at}",
        invoice: self
      ) unless bookkeeping.present?
    elsif paid? && saved_change_to_amount?
      # jika status paid dan amount berubah → update bookkeeping
      bookkeeping.update(amount: amount) if bookkeeping.present?
    end
  end

end
