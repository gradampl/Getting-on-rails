# frozen_string_literal: true

class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create]
  before_action :article, only: %i[create destroy]
  before_action only: %i[destroy] do
    owner_object? @article
  end

  def create
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def article
    @article ||= Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
