class Api::PingsController < Api::BaseController
  def create

    CleanupPresenceWorker.perform_async(params[:tags], params[:room_id])
    JSON.parse(params[:tags]).each_pair do |k,v|
      UpdatePresenceWorker.perform_async(v, params[:room_id])
    end
    render json: {status: :ok}
  end
end
