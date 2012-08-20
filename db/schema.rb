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

ActiveRecord::Schema.define(:version => 20120820210547) do

  create_table "events", :force => true do |t|
    t.text     "description"
    t.time     "time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "month_days", :force => true do |t|
    t.integer  "event_id"
    t.integer  "day"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "month_days", ["event_id", "day"], :name => "index_month_days_on_event_id_and_day", :unique => true
  add_index "month_days", ["event_id"], :name => "index_month_days_on_event_id"

  create_table "months", :force => true do |t|
    t.integer  "event_id"
    t.integer  "month"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "months", ["event_id", "month"], :name => "index_months_on_event_id_and_month", :unique => true
  add_index "months", ["event_id"], :name => "index_months_on_event_id"

  create_table "week_days", :force => true do |t|
    t.integer  "event_id"
    t.integer  "day"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "week_days", ["event_id", "day"], :name => "index_week_days_on_event_id_and_day", :unique => true
  add_index "week_days", ["event_id"], :name => "index_week_days_on_event_id"

  create_table "years", :force => true do |t|
    t.integer  "event_id"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "years", ["event_id", "year"], :name => "index_years_on_event_id_and_year", :unique => true
  add_index "years", ["event_id"], :name => "index_years_on_event_id"

end
