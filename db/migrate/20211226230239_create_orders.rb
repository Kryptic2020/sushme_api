class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.float :total_amount
      t.datetime :delivery_time
      t.boolean :isTakeAway
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.references :status, null: false, foreign_key: true
      t.references :table, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
