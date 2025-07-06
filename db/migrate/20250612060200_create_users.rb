# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 100, comment: 'メールアドレス'
      t.string :encrypted_password, null: false, comment: 'パスワード'
      t.string :nickname, null: false, limit: 50, comment: 'ニックネーム'
      t.string :first_name, limit: 30, comment: '名'
      t.string :last_name, limit: 30, comment: '姓'

      t.string :jti, null: false, comment: '認証用'
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.datetime :discarded_at, comment: '論理削除日時'
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :jti, unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
