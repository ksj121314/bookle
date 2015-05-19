class CreatePurchaseLists < ActiveRecord::Migration
  def change
    create_table :purchase_lists do |t|
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
