class CreateBookkeepings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookkeepings do |t|
      t.date :date
      t.decimal :amount
      t.integer :status
      t.integer :category
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
