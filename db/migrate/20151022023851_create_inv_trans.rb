class CreateInvTrans < ActiveRecord::Migration
  def change
    create_table :inv_trans do |t|
      t.integer :amount
      t.string :transaction_desc
      t.date :transaction_date
      t.integer :investment_id

      t.timestamps null: false
    end
  end
end
