class CreateKeyQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :key_questions do |t|
      t.text :name
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :key_questions, :deleted_at
  end
end