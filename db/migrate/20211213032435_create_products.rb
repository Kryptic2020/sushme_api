class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.float :price
      t.text :description
      t.string :status
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
