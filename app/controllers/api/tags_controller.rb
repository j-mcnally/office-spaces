class Api::TagsController < Api::BaseController
  def create
    tag = Tag.create_for_user(tag_params)
    render json: tag
  end

  private def tag_params
    params.require(:tag).permit(:name, :identifier, :name, :user_name, :email)
  end
end
