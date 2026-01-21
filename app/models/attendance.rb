class Attendance < ApplicationRecord
  belongs_to :student
  belongs_to :invoice
  belongs_to :user, optional: true

  enum status: { alpa: 0, hadir: 1 }, _prefix: :status
end
