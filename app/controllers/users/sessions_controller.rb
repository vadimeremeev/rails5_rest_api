class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  respond_to :html, :json

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    respond_to do |format|
      format.html { super }
      format.json {
        if current_user.present?
          render json: {success: true, user: current_user}
        else
          render json: {success: false, code: 'Wrong Credentials'}, status: :unprocessable_entity
        end
      }
    end
  end

  # DELETE /resource/sign_out
  def destroy
    respond_to do |format|
      format.html { super }
      format.json {
        render json: {success: true}
      }
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
