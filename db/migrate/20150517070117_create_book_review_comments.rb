class CreateBookReviewComments < ActiveRecord::Migration
  def change
    create_table :book_review_comments do |t|
      t.integer :user_id
      t.integer :book_review_id
      t.string  :content

      t.timestamps
    end
  end
end
