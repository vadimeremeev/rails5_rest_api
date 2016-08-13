class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

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
        @user = User.new(:email => params[:user][:email], :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
        @user.save
        render json: {success: true}
      }
    end
  end

  # GET /resource/edit
  def edit
    respond_to do |format|
      format.html { super }
      format.json { render json: {success: true} }
    end
  end

  # PUT /resource
  def update
    respond_to do |format|
      format.html { super }
      format.json { render json: {success: true} }
    end
  end

  # DELETE /resource
  def destroy
    respond_to do |format|
      format.html { super }
      format.json { render json: {sucess: true} }
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

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
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