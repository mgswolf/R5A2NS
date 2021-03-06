class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :done, default: false
      t.datetime :deadline
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
