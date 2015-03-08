class Api::RoomsController < Api::BaseController
  
  def create
    Room.create(room_params)
  end

  def index
    r = Room.all
    render json: r
  end

  def show
    r = Room.find(params[:id])
    render json: r
  end

  private def room_params
    params.require(:room).permit(:name, :location)
  end
end
