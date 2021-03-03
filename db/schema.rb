# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_03_085208) do

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "user_name"
    t.date "begin_date"
    t.date "end_date"
    t.integer "amount_month"
    t.integer "amount_count"
    t.integer "cycle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "invoices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.date "begin_date"
    t.date "end_date"
    t.date "pay_date"
    t.integer "amount_count"
    t.bigint "contract_id", null: false
    t.bigint "renting_phase_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id"], name: "index_invoices_on_contract_id"
    t.index ["renting_phase_id"], name: "index_invoices_on_renting_phase_id"
  end

  create_table "line_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "date_type"
    t.integer "date_number"
    t.integer "unit_price"
    t.date "begin_date"
    t.date "end_date"
    t.date "pay_date"
    t.integer "amount_count"
    t.bigint "invoice_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  create_table "renting_phases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.date "begin_date"
    t.date "end_date"
    t.date "pay_date"
    t.integer "amount_count"
    t.integer "contract_index"
    t.integer "invoice_status"
    t.bigint "contract_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contract_id"], name: "index_renting_phases_on_contract_id"
  end

  add_foreign_key "invoices", "contracts"
  add_foreign_key "invoices", "renting_phases"
  add_foreign_key "line_items", "invoices"
  add_foreign_key "renting_phases", "contracts"
end
