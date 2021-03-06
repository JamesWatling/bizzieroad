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

ActiveRecord::Schema.define(version: 20150331211059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "provider_id"
    t.string   "decision_maker"
    t.string   "decision_maker_position"
    t.string   "decision_maker_location"
    t.string   "email"
    t.string   "initial_contact_person"
    t.string   "connections"
    t.string   "connection_type"
    t.datetime "renewal_date"
    t.integer  "interest_level"
    t.text     "notes"
    t.string   "rep_name"
  end

  add_index "companies", ["provider_id"], name: "index_companies_on_provider_id", using: :btree

  create_table "providers", force: true do |t|
    t.integer  "industry_id"
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "default_icon_file_name"
    t.string   "default_icon_content_type"
    t.integer  "default_icon_file_size"
    t.datetime "default_icon_updated_at"
    t.string   "hot_icon_file_name"
    t.string   "hot_icon_content_type"
    t.integer  "hot_icon_file_size"
    t.datetime "hot_icon_updated_at"
  end

  add_index "providers", ["industry_id"], name: "index_providers_on_industry_id", using: :btree

  create_table "services", force: true do |t|
    t.integer  "company_id"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "services", ["company_id"], name: "index_services_on_company_id", using: :btree
  add_index "services", ["provider_id"], name: "index_services_on_provider_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "full_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
