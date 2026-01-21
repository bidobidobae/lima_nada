class Student < ApplicationRecord
  belongs_to :user, optional: true
  has_many :invoices, dependent: :destroy
  has_many :attendances, dependent: :destroy

  enum diagnosis: {
    autistic: 0,
    down_syndrome: 1,
    tuna_grahita: 2,
    celebral_palsy: 3,
    spectrum_autis: 4,
    adhd: 5,
    asd: 6,
    non_disabilitas: 7,
    disleksia: 8,
    kurang_konsentrasi: 9
  }
end
