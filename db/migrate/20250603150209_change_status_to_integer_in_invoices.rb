class ChangeStatusToIntegerInInvoices < ActiveRecord::Migration[7.2]
  def up
    execute <<-SQL
      ALTER TABLE invoices
      ALTER COLUMN status TYPE integer USING (status::integer),
      ALTER COLUMN status SET DEFAULT 0,
      ALTER COLUMN status SET NOT NULL;
    SQL
  end

  def down
    execute <<-SQL
      ALTER TABLE invoices
      ALTER COLUMN status TYPE varchar,
      ALTER COLUMN status DROP DEFAULT,
      ALTER COLUMN status DROP NOT NULL;
    SQL
  end

end
