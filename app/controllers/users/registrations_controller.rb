class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :set_user, only: [:update, :destroy]

  respond_to :html, :json

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    respond_to do |format|
      format.html { super }
      format.json {
        unless User.where(email: params[:user][:email]).exists?
          @user = User.new(
            email: params[:user][:email],
            password: params[:user][:password],
            password_confirmation: params[:user][:password_confirmation],
            name: params[:user][:name],
            is_admin: params[:user][:is_admin]
          )
          @user.save
          sign_in @user
          render json: {success: true, user: @user}
        else
          render json: {success: false, code: 'User already Exists'}, status: :unprocessable_entity
        end
      }
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    respond_to do |format|
      format.html { super }
      format.json {
        if @user.update(user_params)
          sign_in @user, :bypass => true
          render json: {success: true, user: @user}
        else
          render json: {success: false, code: "Can't update user account"}, status: :unprocessable_entity
        end
      }
    end
  end

  # DELETE /resource
  def destroy
    respond_to do |format|
      format.html { super }
      format.json {
        @timezone.destroy
        render json: {sucess: true}
      }
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
  end

  def set_user
    @user = current_user || User.where(id: params[:user][:id])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
