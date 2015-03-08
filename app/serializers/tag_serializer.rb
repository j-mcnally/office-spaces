class TagSerializer < ActiveModel::Serializer
  attributes :id, :identifier, :name
  has_one :user
end
