class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    render :text => 'Konichiva ... d(^_^)b'
  end
end
