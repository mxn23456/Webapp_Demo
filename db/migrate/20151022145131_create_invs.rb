class CreateInvs < ActiveRecord::Migration
  def change
    create_table :invs do |t|
      t.string :inv_desc, null: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
