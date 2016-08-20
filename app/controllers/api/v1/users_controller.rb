class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_user, only: [:update, :destroy]

  #PUT /api/v1/users/:id
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: unprocessable_entity
    end
  end

  #DELETE /api/v1/users/destroy:id
  def destroy
    @user.authentication_token = nil
    if @user.save
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
