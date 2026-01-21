class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :text
    add_column :users, :phone_number, :string
    add_column :users, :bank_account, :string
    add_column :users, :social_media, :string
  end
end
