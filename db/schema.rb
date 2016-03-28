# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160325222132) do

  create_table "readings", force: :cascade do |t|
    t.string   "title"
    t.integer  "blood_sugar"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  add_index "readings", ["user_id"], name: "index_readings_on_user_id"

  create_table "readings_reports", id: false, force: :cascade do |t|
    t.integer "reading_id", null: false
    t.integer "report_id",  null: false
  end

  add_index "readings_reports", ["reading_id"], name: "index_readings_reports_on_reading_id"
  add_index "readings_reports", ["report_id"], name: "index_readings_reports_on_report_id"

  create_table "reports", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "authorizable_type"
    t.integer  "authorizable_id"
    t.boolean  "system",            default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "reports", ["authorizable_type", "authorizable_id"], name: "index_reports_on_authorizable_type_and_authorizable_id"
  add_index "reports", ["name"], name: "index_reports_on_name"

  create_table "roles", force: :cascade do |t|
    t.string   "name",                              null: false
    t.string   "authorizable_type"
    t.integer  "authorizable_id"
    t.boolean  "system",            default: false, null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "roles", ["authorizable_type", "authorizable_id"], name: "index_roles_on_authorizable_type_and_authorizable_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "failed_login_count", default: 0, null: false
    t.datetime "last_login_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
