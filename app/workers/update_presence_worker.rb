# This almost has to be a sidekiq task because it will re-order ever reservations position.
class UpdatePresenceWorker
  include Sidekiq::Worker
  sidekiq_options queue: :update, retry: false

  
  def perform(payload, room_id)
    puts "Updating!!!!!"
    o = JSON.parse(payload)
    d = o["data"]
    id = d["identifier"]
    t = Tag.find_by(identifier: id)
    t.presentInRoom(room_id) if t.present?
  end
end