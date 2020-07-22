# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
    authorize @articles
  end

  def show; end

  def new
    @article = Article.new
    authorize @article
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    authorize @article

    if @article.save
      redirect_to @article, notice: 'Article successfully created.'
    else
      render 'new'
    end
  end

  def update
    if article.update(article_params)
      redirect_to article, notice: 'Article successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    article.destroy

    redirect_to articles_path, notice: 'Article successfully destroyed.'
  end

  private

  def article
    @article ||= Article.find(params[:id])
    authorize @article
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
