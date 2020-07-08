# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  def owner?(user_id)
    return if user_id == current_user.id

    redirect_to articles_path, notice: "Action not allowed!!"
    # render json: nil, status: :forbidden
    # nil
  end

  def owner_object?(data)
    if data.nil? || data.user_id.nil?
      redirect_to articles_path, notice: "Action not allowed!"
      # render status: :not_found
    else
      owner? data.user_id
    end
  end
end
