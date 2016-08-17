class Api::V1::TimezonesController < Api::V1::ApplicationController

  before_filter :set_timezone, only: [:show, :update, :destroy]
  before_filter :set_user, only: [:create, :update]

  #GET /api/v1/timezones
  def index
    @timezones = Timezone.all
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
      @timezone = Timezone.find(params[:id])
    end

    def timezone_params
      params.require(:timezone).permit(:name, :city, :gmt_offset, :user_id)
    end

end
