class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: ENV['OWNER_NAME'], password: ENV['OWNER_PASSWORD'], except: [:index, :show]
  before_action :authenticate_user!, unless: :devise_controller?
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    @articles = Article.all
    end

  def show
    find_params
  end

  def new
    @article = Article.new
  end

  def edit
    find_params
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
    find_params

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    find_params
    @article.destroy

    redirect_to articles_path
  end

  private

  def find_params
    @article = Article.find(params[:id])
    end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
