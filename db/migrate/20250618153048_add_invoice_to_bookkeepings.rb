class AddInvoiceToBookkeepings < ActiveRecord::Migration[7.2]
  def change
    add_reference :bookkeepings, :invoice, foreign_key: true
  end
end
