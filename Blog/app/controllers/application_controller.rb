# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  def owner?(user_id)
    return if user_id == current_user.id

    redirect_to articles_path, notice: "Action not allowed!!"
  end

  def owner_object?(data)
    if data&.user_id
      owner? data.user_id
    else
      redirect_to articles_path, notice: "Action not allowed!"
    end
  end
end
