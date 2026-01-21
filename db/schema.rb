# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_06_21_124130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "invoice_id", null: false
    t.date "meeting_date"
    t.integer "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_attendances_on_invoice_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bookkeepings", force: :cascade do |t|
    t.date "date"
    t.decimal "amount"
    t.integer "status"
    t.integer "category"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.bigint "salary_id"
    t.index ["invoice_id"], name: "index_bookkeepings_on_invoice_id"
    t.index ["salary_id"], name: "index_bookkeepings_on_salary_id"
    t.index ["user_id"], name: "index_bookkeepings_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "student_id", null: false
    t.date "meeting_date_1"
    t.date "meeting_date_2"
    t.date "meeting_date_3"
    t.date "meeting_date_4"
    t.decimal "amount"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_invoices_on_student_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "salaries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "amount", null: false
    t.integer "salary_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_salaries_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "contact_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "birth_date"
    t.date "joined_at"
    t.integer "diagnosis"
    t.string "keanggotaan"
    t.string "parent_name"
    t.text "address"
    t.string "social_media"
    t.string "contact_email"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 1
    t.string "name"
    t.text "address"
    t.string "phone_number"
    t.string "bank_account"
    t.string "social_media"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "invoices"
  add_foreign_key "attendances", "students"
  add_foreign_key "attendances", "users"
  add_foreign_key "bookkeepings", "invoices"
  add_foreign_key "bookkeepings", "salaries"
  add_foreign_key "bookkeepings", "users"
  add_foreign_key "invoices", "students"
  add_foreign_key "invoices", "users"
  add_foreign_key "salaries", "users"
end
