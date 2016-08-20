class Api::V1::ApplicationController < ApplicationController
  before_action :default_format

  respond_to :json

  private

  def default_format
    request.format = :json
  end
end