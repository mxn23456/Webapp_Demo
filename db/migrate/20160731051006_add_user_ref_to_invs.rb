class AddUserRefToInvs < ActiveRecord::Migration
  def change
    add_reference :invs, :user, index: true, foreign_key: true
  end
end
