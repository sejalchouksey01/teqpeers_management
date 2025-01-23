class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.text :detail
      t.integer :rating
      t.jsonb :feedback_data
      t.string :from_to_date
      t.references :mentor, null: false, foreign_key: { to_table: :users }
      t.references :trainee, null: false, foreign_key: { to_table: :users }
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
