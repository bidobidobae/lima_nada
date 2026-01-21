class Bookkeeping < ApplicationRecord
  belongs_to :user
  belongs_to :invoice, optional: true
  belongs_to :salary, optional: true
  validates :invoice_id, uniqueness: true, allow_nil: true
  validates :salary_id, uniqueness: true, allow_nil: true

  enum status: { masuk: 0, keluar: 1 }
  enum category: {
    pendaftaran: 0,
    iuran_kursus: 1,
    donasi: 2,
    intern: 3,
    sertifikasi: 4,
    program_kakak_asuh: 5,
    event: 6,
    merchendise: 7,
    salary: 8,
    transport: 9,
    pembuatan_materi: 10,
    alat_peraga: 11,
    marketing: 12,
    beasiswa: 13,
    sewa_tempat: 14,
    listrik: 15,
    internet: 16,
    hosting: 17,
    air: 18,
    konsumsi: 19,
    akta: 20,
    perizinan: 21,
    pengembangan_SDM: 22
  }
end
