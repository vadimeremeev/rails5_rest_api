class Api::V1::TimezonesController < Api::V1::ApplicationController

  before_action :set_timezone, only: [:show, :update, :destroy]
  before_action :set_user, only: [:create, :update]

  #GET /api/v1/timezones
  def index
    @timezones = Timezone.filtered_by_user(current_user).page(params[:page]).per(params[:size])
  end

  #GET /api/v1/timezones/:id
  def show
    @timezone
  end

  #POST /api/v1/timezones
  def create
    @timezone = Timezone.new(timezone_params)

    if @timezone.save
      render :show
    else
      render json: @timezone.errors, status: unprocessable_entity
    end
  end

  #PUT /api/v1/timezones/:id
  def update
    if @timezone.update(timezone_params)
      render :show
    else
      render json: @timezone.errors, status: unprocessable_entity
    end
  end

  #DELETE /api/v1/timezones/:id
  def destroy
    @timezone.destroy
  end

  #GET /api/v1/timezones/search/:q
  def search
    @timezones = Timezone.filtered_by_user(current_user).search(params[:q]).page(params[:page]).per(params[:size])
    render :index
  end

  private
    def set_user
      params[:timezone][:user_id] = current_user.id if current_user.present?
    end

    def set_timezone
      @timezone = Timezone.find_by_id(params[:id])
      unless @timezone.present?
        render json: { success: false, code: 'Record Do Not Exists' }, status: 404
      end
      unless current_user.is_admin? || (@timezone.user_id == current_user.id)
        render json: { success: false, code: 'Access Error' }, status: 422
      end
    end

    def timezone_params
      params.require(:timezone).permit(:name, :city, :gmt_offset, :user_id)
    end

end
