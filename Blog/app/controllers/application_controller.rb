class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: ENV['OWNER_NAME'], password: ENV['OWNER_PASSWORD'], except: [:index, :show]
end
