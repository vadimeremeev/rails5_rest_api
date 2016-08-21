class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user

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
    @user = current_user || User.where(id: params[:user][:id])
    unless @user.present?
      render json: { success: false, code: 'Record Do Not Exists' }, status: 404
    end
    unless current_user.is_admin? || (@user.user_id == current_user.id)
      render json: { success: false, code: 'Access Error' }, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
  end

end
