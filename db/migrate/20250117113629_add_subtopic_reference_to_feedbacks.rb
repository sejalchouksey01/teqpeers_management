class AddSubtopicReferenceToFeedbacks < ActiveRecord::Migration[8.0]
  def change
    add_reference :feedbacks, :subtopic, foreign_key: true
  end
end
