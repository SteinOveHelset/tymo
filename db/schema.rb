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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_173258) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "title", null: false
    t.text "description", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id", null: false
    t.string "color"
    t.index ["created_by_id"], name: "index_clients_on_created_by_id"
    t.index ["team_id"], name: "index_clients_on_team_id"
  end

  create_table "entries", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "client_id", null: false
    t.integer "project_id", null: false
    t.text "description", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.integer "minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id", null: false
    t.index ["client_id"], name: "index_entries_on_client_id"
    t.index ["created_by_id"], name: "index_entries_on_created_by_id"
    t.index ["project_id"], name: "index_entries_on_project_id"
    t.index ["team_id"], name: "index_entries_on_team_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "client_id", null: false
    t.integer "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id", null: false
    t.integer "budget"
    t.index ["client_id"], name: "index_projects_on_client_id"
    t.index ["created_by_id"], name: "index_projects_on_created_by_id"
    t.index ["team_id"], name: "index_projects_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by_id", null: false
    t.index ["created_by_id"], name: "index_teams_on_created_by_id"
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "password_confirmation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "clients", "teams"
  add_foreign_key "clients", "users", column: "created_by_id"
  add_foreign_key "entries", "clients"
  add_foreign_key "entries", "projects"
  add_foreign_key "entries", "teams"
  add_foreign_key "entries", "users", column: "created_by_id"
  add_foreign_key "projects", "clients"
  add_foreign_key "projects", "teams"
  add_foreign_key "projects", "users", column: "created_by_id"
  add_foreign_key "teams", "users", column: "created_by_id"
end
