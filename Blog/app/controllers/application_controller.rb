class ApplicationController < ActionController::Base
   @owner_name = ENV['OWNER_NAME']
   @owner_password = ENV['OWNER_PASSWORD']
   http_basic_authenticate_with name: @owner_name, password: @owner_password, except: [:index, :show, :create]
end
