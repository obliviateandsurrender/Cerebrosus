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

ActiveRecord::Schema.define(version: 20170913205728) do

  create_table "answers", force: :cascade do |t|
    t.string "answer", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.integer "questions_id"
    t.index ["questions_id"], name: "index_answers_on_questions_id"
    t.index ["users_id"], name: "index_answers_on_users_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "finished_quizzes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.integer "quizzes_id"
    t.index ["quizzes_id"], name: "index_finished_quizzes_on_quizzes_id"
    t.index ["users_id"], name: "index_finished_quizzes_on_users_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "body", default: "", null: false
    t.string "option1", default: "", null: false
    t.string "option2", default: "", null: false
    t.string "option3", default: "", null: false
    t.string "option4", default: "", null: false
    t.string "answer", default: "", null: false
    t.string "format", default: "text"
    t.string "asset", default: ""
    t.datetime "updated_at", null: false
    t.datetime "created_at", null: false
    t.integer "quizzes_id"
    t.boolean "multiple", default: false, null: false
    t.index ["quizzes_id"], name: "index_questions_on_quizzes_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title", limit: 30, default: "", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_playable", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "subcategories_id"
    t.index ["subcategories_id"], name: "index_quizzes_on_subcategories_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.integer "quizzes_id"
    t.index ["quizzes_id"], name: "index_scores_on_quizzes_id"
    t.index ["users_id"], name: "index_scores_on_users_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.boolean "oauth", default: false, null: false
    t.string "hash", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_id"
    t.index ["users_id"], name: "index_sessions_on_users_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "categories_id"
    t.index ["categories_id"], name: "index_subcategories_on_categories_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 50, default: "", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", null: false
    t.string "username", limit: 20, null: false
    t.boolean "admin", default: false
    t.integer "signin_count", default: 0, null: false
    t.boolean "rememberme_token", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
