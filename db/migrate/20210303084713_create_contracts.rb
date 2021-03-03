class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.string :user_name
      t.date :begin_date
      t.date :end_date
      t.integer :amount_month
      t.integer :amount_count
      t.integer :cycle

      t.timestamps
    end
  end
end
