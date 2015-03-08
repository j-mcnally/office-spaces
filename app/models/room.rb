class Room < ActiveRecord::Base
  has_many :presences
  has_many :tags, through: :presences
end
