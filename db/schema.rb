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

ActiveRecord::Schema.define(version: 2021_01_28_014623) do

  create_table "answers", force: :cascade do |t|
    t.text "content"
    t.datetime "answered_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "formulary_id", null: false
    t.integer "question_id", null: false
    t.integer "visit_id", null: false
    t.index ["formulary_id"], name: "index_answers_on_formulary_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["visit_id"], name: "index_answers_on_visit_id"
  end

  create_table "formularies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.text "question_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "formulary_id", null: false
    t.index ["formulary_id"], name: "index_questions_on_formulary_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password"
    t.string "email"
    t.string "cpf"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "visits", force: :cascade do |t|
    t.date "date"
    t.string "status", default: "pending"
    t.datetime "checkin_at"
    t.datetime "checkout_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  add_foreign_key "answers", "formularies"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "visits"
  add_foreign_key "questions", "formularies"
  add_foreign_key "visits", "users"
end
