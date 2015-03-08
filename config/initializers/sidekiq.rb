Sidekiq.configure_server do |config|
  ActiveRecord::Base.connection.disconnect!
  ActiveRecord::Base.configurations[Rails.env]['pool'] = 55
  ActiveRecord::Base.establish_connection
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'officespace' }
end

Sidekiq.configure_client do |config|
  config.redis = { :url => ENV['REDIS_URL'], :namespace => 'officespace' }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == %w(admin eeb84761)
end
