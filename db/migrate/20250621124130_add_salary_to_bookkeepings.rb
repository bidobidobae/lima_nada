class AddSalaryToBookkeepings < ActiveRecord::Migration[7.2]
  def change
    add_reference :bookkeepings, :salary, foreign_key: true
  end
end
