class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.date :meeting_date_1
      t.date :meeting_date_2
      t.date :meeting_date_3
      t.date :meeting_date_4
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
