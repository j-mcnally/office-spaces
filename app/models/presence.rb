class Presence < ActiveRecord::Base
  acts_as_paranoid
  
  belongs_to :tag
  belongs_to :room

  def user
    tag.user
  end
end
