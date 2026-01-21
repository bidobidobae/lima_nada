class AddDetailsToStudents < ActiveRecord::Migration[7.2]
  def change
    add_column :students, :birth_date, :date
    add_column :students, :joined_at, :date
    add_column :students, :diagnosis, :integer
    add_column :students, :keanggotaan, :string
    add_column :students, :parent_name, :string
    add_column :students, :address, :text
    add_column :students, :social_media, :string
    add_column :students, :contact_email, :string
  end
end
