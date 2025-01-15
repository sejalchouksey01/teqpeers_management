class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.text :detail
      t.integer :rating
      t.references :user_given, null: false, foreign_key: { to_table: :users }
      t.references :user_received, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
