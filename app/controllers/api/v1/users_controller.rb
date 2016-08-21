class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user
  before_action :authorize_admin, only: [:index]
  before_action :authorize_user, only: [:show, :update, :logout, :destroy]

  #GET /api/v1/users
  def index
    @users = User.all.page(params[:page]).per(params[:size])
  end

  #GET /api/v1/users/:id
  def show
    @user
  end

  #PUT /api/v1/users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: unprocessable_entity
    end
  end

  #GET /api/v1/users/logout
  def logout
    sign_out @user
    if current_user.nil?
      render json: {status: true}
    else
      render json: {status: false, message: "Error happen during logging out"}, status: unprocessable_entity
    end
  end

  #DELETE /api/v1/users/:id
  def destroy
    if @user.destroy
      render json: {status: true}
    else
      render json: @user.errors, status: unprocessable_entity
    end
  end


  private

  def set_user
    @user = User.where(id: params[:id]).first || current_user
    unless @user.present?
      render json: { success: false, code: 'Record Do Not Exists' }, status: 404
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
  end

  def authorize_admin
    unless current_user.is_admin?
      render json: { success: false, code: 'Access Error' }, status: 422
    end
  end

  def authorize_user
    unless current_user.is_admin? || (@user.id == current_user.id)
      render json: { success: false, code: 'Access Error' }, status: 422
    end
  end

end
