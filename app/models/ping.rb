class Ping
    include Mongoid::Document
    field :time, type: DateTime
    field :name, type: String
    field :rssi, type: Integer
    field :tag_id, type: String
    field :room_id, type: Integer

    def room
      Room.find(self.room_id) if self.room_id
    end

    def tag
      Tag.find_by(indentifier: self.tag_id) if self.tag_id
    end

    def user
      tag.user if tag.present?
    end
end