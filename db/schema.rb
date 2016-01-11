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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150919064808) do

  create_table "bookings", :force => true do |t|
    t.text     "title"
    t.integer  "user_id",     :null => false
    t.integer  "facility_id", :null => false
    t.datetime "start_time",  :null => false
    t.datetime "end_time",    :null => false
    t.text     "memo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "facilities", :force => true do |t|
    t.string   "name",                      :null => false
    t.string   "kana",                      :null => false
    t.string   "sub_name"
    t.string   "sub_kana"
    t.integer  "status",     :default => 0, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "family_name",                :null => false
    t.string   "first_name",                 :null => false
    t.string   "family_kana",                :null => false
    t.string   "first_kana",                 :null => false
    t.integer  "status",      :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

end
