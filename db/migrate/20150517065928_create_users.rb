class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username
      t.string  :password
      t.integer :money

      t.timestamps
    end
  end
end
