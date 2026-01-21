class CreateAttendances < ActiveRecord::Migration[7.2]
  def change
    create_table :attendances do |t|
      t.references :student, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.date :meeting_date
      t.integer :status
      t.references :user, null: true, foreign_key: true

      t.timestamps
    end
  end
end
