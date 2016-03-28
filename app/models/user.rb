class User < ActiveRecord::Base
  acts_as_authentic
  has_many :readings, dependent: :destroy

  def to_s
    email
  end

end