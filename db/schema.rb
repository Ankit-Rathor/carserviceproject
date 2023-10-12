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

ActiveRecord::Schema[7.0].define(version: 2023_09_29_061900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "city"
    t.string "location"
    t.string "house_no"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "date"
    t.bigint "user_id", null: false
    t.integer "service_id"
    t.bigint "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "mechanic_id"
    t.string "issue"
    t.string "status"
    t.index ["car_id"], name: "index_bookings_on_car_id"
    t.index ["service_id"], name: "index_bookings_on_service_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "number"
    t.string "name"
    t.string "model"
    t.string "company"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cars_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.json "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "contact"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "bookings", "cars"
  add_foreign_key "bookings", "services"
  add_foreign_key "bookings", "users"
  add_foreign_key "cars", "users"
end
