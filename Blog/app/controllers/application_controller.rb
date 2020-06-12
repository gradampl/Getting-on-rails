class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  skip_before_action :authenticate_user!, only: [:show, :index, :create]
end
