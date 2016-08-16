class Api::V1::ApplicationController < ApplicationController
  respond_to :html, :json

  acts_as_token_authentication_handler_for User

  before_filter :default_format

  private

  def default_format
    request.format = :json
  end
end