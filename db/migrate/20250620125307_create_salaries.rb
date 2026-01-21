class CreateSalaries < ActiveRecord::Migration[7.2]
  def change
    create_table :salaries do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :amount, null: false
      t.integer :salary_type, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.integer :month, null: false
      t.integer :year, null: false

      t.timestamps
    end
  end
end
