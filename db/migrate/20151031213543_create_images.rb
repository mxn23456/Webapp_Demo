class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
		t.attachment :image
		t.integer :inv_id

      t.timestamps null: false
    end
  end
end
