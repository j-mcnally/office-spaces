class Tag < ActiveRecord::Base
  belongs_to :user

  after_create do
    name = self.name || "tag-#{self.id}"
    resp = gimbal.register_tag(identifier: self.identifier, name: name)
    puts resp.inspect
    puts "BODY:::::: " + resp.body
  end

  def self.create_for_user(options)
    email = options["email"]
    uname = options["user_name"]
    u = User.find_or_create_by(email: email)
    u.name = uname
    u.save(validate: false)

    identifier = options["identifier"]
    name = options["name"]

    tag  = Tag.find_or_create_by(name: name, identifier: identifier)
    tag.user = u
    tag.save
  end

  def presentInRoom(room_id)
    p = Presence.find_or_create_by(tag_id: self.id, room_id: room_id)
    p.touch
  end

  def gimbal
    @g ||= Gimbal.new
  end

end
