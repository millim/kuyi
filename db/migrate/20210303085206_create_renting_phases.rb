class CreateRentingPhases < ActiveRecord::Migration[6.0]
  def change
    create_table :renting_phases do |t|
      t.date :begin_date
      t.date :end_date
      t.date :pay_date
      t.integer :amount_count
      t.integer :contract_index
      t.integer :invoice_status
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
