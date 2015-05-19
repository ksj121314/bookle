class CreateBookReviews < ActiveRecord::Migration
  def change
    create_table :book_reviews do |t|
      t.integer :user_id
      t.integer :book_id
      t.string  :title
      t.text    :content

      t.timestamps
    end
  end
end
