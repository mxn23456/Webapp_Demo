class AddAttachmentImageToInvs < ActiveRecord::Migration
  def self.up
    change_table :invs do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :invs, :image
  end
end
