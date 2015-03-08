# This almost has to be a sidekiq task because it will re-order ever reservations position.
class CleanupPresenceWorker
  include Sidekiq::Worker
  sidekiq_options queue: :update, retry: false

  
  def perform(payload, room_id)
    o = JSON.parse(payload)
    user_ids = []
    ts = o.collect do |t,v|
      vd = JSON.parse(v)
      d = vd["data"]
      d["identifier"]
    end
    ts = ts.reject{|t| t.nil?}

    puts "TAGS ===" + ts.inspect
    tags = Tag.where(identifier: ts)
    tag_ids = tags.collect{|t| t.id}

    puts tag_ids.inspect

    if tag_ids.present?
      Presence.where(room_id: room_id).where("tag_id NOT IN (#{tag_ids.join(',')})").destroy_all
    else
      Presence.where(room_id: room_id).destroy_all
    end
  end
end