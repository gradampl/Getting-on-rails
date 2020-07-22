# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def destroy?
    return true if user.id == @record.id
  end
end
