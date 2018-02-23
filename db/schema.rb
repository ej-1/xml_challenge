# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180218173708) do

  create_table "debtors", force: :cascade do |t|
    t.string "system_id"
    t.string "customer_number"
    t.string "gender"
    t.string "first_name"
    t.string "last_name"
    t.string "iso_code_language"
    t.string "iso_code_communication_language"
    t.string "iso_code_address_country"
    t.string "zip"
    t.string "city"
    t.string "street"
    t.string "house_number"
    t.string "phone_number"
    t.string "mobile_phone_number"
    t.string "email_address"
    t.string "sap_invoice_number"
    t.string "fixed_value"
    t.float "amount"
    t.datetime "date_of_export_to_debt_collection"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
