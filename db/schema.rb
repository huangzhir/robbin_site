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

ActiveRecord::Schema.define(:version => 10) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "blogs_count",      :default => 0
  end

  create_table "blog_comments", :force => true do |t|
    t.integer  "account_id"
    t.integer  "blog_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_comments", ["account_id"], :name => "index_blog_comments_on_account_id"
  add_index "blog_comments", ["blog_id"], :name => "index_blog_comments_on_blog_id"

  create_table "blog_contents", :force => true do |t|
    t.text "content", :limit => 16777215, :null => false
  end

  create_table "blogs", :force => true do |t|
    t.string   "title",                                :null => false
    t.string   "slug_url"
    t.integer  "view_count",         :default => 0
    t.integer  "blog_content_id",                      :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "account_id"
    t.integer  "comments_count",     :default => 0
    t.datetime "content_updated_at"
    t.boolean  "commentable",        :default => true, :null => false
    t.boolean  "original",           :default => true, :null => false
    t.string   "original_url"
    t.string   "cached_tag_list"
  end

  add_index "blogs", ["account_id"], :name => "index_blogs_on_account_id"
  add_index "blogs", ["blog_content_id"], :name => "index_blogs_on_blog_content_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

end
