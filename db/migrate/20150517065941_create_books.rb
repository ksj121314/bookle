class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :user_id
      t.string  :category
      t.string  :title
      t.text    :content
      t.integer :price
      t.integer :publicdate
      t.string  :out

      t.timestamps
    end
  end
end
