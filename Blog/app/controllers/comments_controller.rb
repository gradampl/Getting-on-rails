# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :article

  def create
    @comment = article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @comment = article.comments.find(params[:id])
    authorize @comment
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
