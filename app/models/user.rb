class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable

  has_many :invs
end
