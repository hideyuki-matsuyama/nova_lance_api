# frozen_string_literal: true

class CreateExamples < ActiveRecord::Migration[8.0]
  def change
    create_table :examples do |t|
      t.string :first_name, comment: '名'
      t.string :last_name, comment: '姓'
      t.timestamps
    end
  end
end
