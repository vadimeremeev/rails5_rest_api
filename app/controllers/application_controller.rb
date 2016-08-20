class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format =~ %r{application/json} }

  acts_as_token_authentication_handler_for User, fallback_to_devise: true

  def index
    if user_signed_in?
      render :text => "Konichiva <i>#{current_user.email}</i>!<br /> <a href='/users/sign_out'>Logout</a>"
     else
      render :text => "Konichiva <i>d(^_^)b</i> <br /> <a href='/users/sign_in'>Sign In</a>"
    end
  end
end
