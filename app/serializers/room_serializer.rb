class RoomSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :users

  def users
    object.tags.collect{|t| t.user }.uniq
  end

end
