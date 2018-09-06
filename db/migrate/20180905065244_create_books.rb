class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :price
      t.string :publisher

      t.timestamps
    end
  end
end
