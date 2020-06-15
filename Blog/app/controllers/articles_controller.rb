# frozen_string_literal: true

class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @articles = Article.all
  end

  def show
    find_article
  end

  def new
    @article = Article.new
  end

  def edit
    find_article
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if article.update(article_params)
      redirect_to article
    else
      render 'edit'
    end
  end

  def destroy
    article.destroy

    redirect_to articles_path
  end

  private

  def article
    @article ||= Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
