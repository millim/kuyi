class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.integer :date_type
      t.integer :date_number
      t.integer :unit_price
      t.date :begin_date
      t.date :end_date
      t.date :pay_date
      t.integer :amount_count
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
