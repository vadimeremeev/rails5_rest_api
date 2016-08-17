class Api::V1::TimezonesController < Api::V1::ApplicationController

  before_action :set_timezone, only: [:show, :update, :destroy]
  before_action :set_user, only: [:create, :update]

  #GET /api/v1/timezones
  def index
    @timezones = Timezone.filtered_by_user(current_user)
  end

  #GET /api/v1/timezones/:id
  def show
    @timezone
  end

  def create
    @timezone = Timezone.new(timezone_params)

    if @timezone.save
      render :show
    else
      render json: @timezone.errors, status: unprocessable_entity
    end
  end

  def update
    if @timezone.update(timezone_params)
      render :show
    else
      render json: @timezone.errors, status: unprocessable_entity
    end
  end

  def destroy
    @timezone.destroy
  end

  private
    def set_user
      params[:timezone][:user_id] = current_user.id if current_user.present?
    end

    def set_timezone
      @timezone = Timezone.find_by_id(params[:id])
      unless @timezone.present?
        render json: { message: 'Record Do Not Exists' }, status: 404
      end
      unless current_user.is_admin? || (@timezone.user_id == current_user.id)
        render json: { message: 'Access Error' }, status: 422
      end
    end

    def timezone_params
      params.require(:timezone).permit(:name, :city, :gmt_offset, :user_id)
    end

end
