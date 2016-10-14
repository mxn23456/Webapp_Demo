class FixColumnName < ActiveRecord::Migration
  def change
	  rename_column :inv_trans, :investment_id, :inv_id
  end
end
