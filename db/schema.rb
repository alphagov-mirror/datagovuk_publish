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

ActiveRecord::Schema.define(version: 2018_10_11_115540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index"
    t.index ["auditable_id", "auditable_type"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "datasets", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "summary"
    t.text "description"
    t.integer "organisation_id"
    t.string "location1"
    t.string "location2"
    t.string "location3"
    t.text "frequency"
    t.integer "creator_id"
    t.boolean "harvested"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.integer "status", default: 0
    t.string "legacy_name"
    t.string "contact_name"
    t.string "contact_email"
    t.string "foi_name"
    t.string "foi_email"
    t.string "foi_web"
    t.string "short_id"
    t.integer "topic_id"
    t.string "licence_code"
    t.string "licence_title"
    t.text "licence_url"
    t.text "licence_custom"
    t.string "schema_id"
    t.index ["short_id"], name: "index_datasets_on_short_id", unique: true
    t.index ["uuid"], name: "index_datasets_on_uuid"
  end

  create_table "inspire_datasets", force: :cascade do |t|
    t.string "bbox_east_long"
    t.string "bbox_west_long"
    t.string "bbox_north_lat"
    t.string "bbox_south_lat"
    t.text "coupled_resource"
    t.text "dataset_reference_date"
    t.string "frequency_of_update"
    t.string "guid"
    t.text "harvest_object_id"
    t.text "harvest_source_reference"
    t.text "import_source"
    t.string "metadata_date"
    t.string "metadata_language"
    t.text "provider"
    t.string "resource_type"
    t.text "responsible_party"
    t.text "spatial"
    t.string "spatial_data_service_type"
    t.string "spatial_reference_system"
    t.bigint "dataset_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.text "access_constraints"
    t.index ["dataset_id"], name: "index_inspire_datasets_on_dataset_id"
    t.index ["uuid"], name: "index_inspire_datasets_on_uuid"
  end

  create_table "links", force: :cascade do |t|
    t.string "name"
    t.text "url"
    t.string "format"
    t.integer "dataset_id"
    t.date "start_date"
    t.date "end_date"
    t.integer "quarter"
    t.boolean "broken"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.datetime "last_modified"
    t.string "type"
    t.index ["dataset_id"], name: "index_links_on_dataset_id"
    t.index ["type"], name: "index_links_on_type"
    t.index ["uuid"], name: "index_links_on_uuid"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "contact_email"
    t.string "contact_name"
    t.string "foi_email"
    t.string "foi_name"
    t.string "foi_web"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.string "govuk_content_id"
    t.index ["uuid"], name: "index_organisations_on_uuid"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "uid"
    t.string "organisation_slug"
    t.string "organisation_content_id"
    t.string "permissions", array: true
    t.boolean "remotely_signed_out", default: false
    t.boolean "disabled", default: false
  end

  add_foreign_key "inspire_datasets", "datasets"
end
