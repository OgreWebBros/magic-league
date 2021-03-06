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

ActiveRecord::Schema.define(version: 2020_08_02_225446) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "set"
    t.string "image_url"
    t.string "multiverse_id"
    t.string "oracle_text"
    t.string "type_line"
    t.string "mana_cost"
    t.decimal "cmc"
    t.string "colors", default: [], array: true
    t.string "rarity"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "winner_id"
    t.integer "loser_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "played_at"
  end

  create_table "ownerships", force: :cascade do |t|
    t.bigint "collection_id"
    t.bigint "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_ownerships_on_card_id"
    t.index ["collection_id"], name: "index_ownerships_on_collection_id"
  end

  create_table "received_trades", force: :cascade do |t|
    t.bigint "user_id"
    t.string "rarity"
    t.integer "num_received"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_received_trades_on_user_id"
  end

  create_table "settings", force: :cascade do |t|
    t.date "season_start_date", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "season_length", default: 365, null: false
    t.integer "base_trade_sets", default: 1, null: false
    t.integer "bonus_trade_users", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tradables", force: :cascade do |t|
    t.bigint "card_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_tradables_on_card_id"
    t.index ["user_id"], name: "index_tradables_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wishes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_wishes_on_card_id"
    t.index ["user_id"], name: "index_wishes_on_user_id"
  end

  add_foreign_key "received_trades", "users"
end
