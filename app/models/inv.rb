class Inv < ActiveRecord::Base

  has_many :inv_trans, dependent: :destroy
  has_many :images, dependent: :destroy
  belongs_to :user
  has_attached_file :image,
    :styles => { large: "600x600>",medium: "300x300>", thumb: "150x150#"},
    :storage => :s3,
    :s3_credentials => Proc.new{|a| a.instance.s3_credentials},
    :s3_region => ENV["AWS_REGION"]
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    def self.get_recent_invs(user, num_of_last_invs)
      inv_id_list = InvTran.getRecentDisctinctInvId(user,num_of_last_invs)
      result_list = []
      #reserving the direction of inv_id_list
      inv_id_list.each do |x|
        inv = Inv.find(x)
        result_list.append inv 
      end
      return result_list
    end

  def s3_credentials
    {:bucket => ENV["S3_BUCKET_NAME"],
      :access_key_id => ENV["AWS_ACCESS_KEY_ID"],
      :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
    }
  end

end
