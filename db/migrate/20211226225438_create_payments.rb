class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :payment_intent_id
      t.string :receipt_url

      t.timestamps
    end
  end
end
