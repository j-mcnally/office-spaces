class Gimbal
  include HTTParty
  base_uri 'https://manager.gimbal.com/api'

  def initialize
    self.class.headers 'Authorization' =>  "Token token=#{ENV['GIMBAL_KEY']}"
    self.class.headers 'Content-Type' => 'application/json'
    @options =  {}
  end

  def register_tag(tag_info)
    factory_id = tag_info[:identifier]
    name = tag_info[:name]

    json = {factory_id: factory_id, name: name}.to_json

    self.class.post("/beacons", body: json)
  end

end