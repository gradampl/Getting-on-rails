class CommentsController < ApplicationController
  http_basic_authenticate_with name: ENV['OWNER_NAME'], password: ENV['OWNER_PASSWORD'], except: [:create]

  def create
    find_params
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    find_params
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def find_params
    @article = Article.find(params[:article_id])
    end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
