class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.date :begin_date
      t.date :end_date
      t.date :pay_date
      t.integer :amount_count
      t.references :contract, null: false, foreign_key: true
      t.references :renting_phase, null: false, foreign_key: true

      t.timestamps
    end
  end
end
