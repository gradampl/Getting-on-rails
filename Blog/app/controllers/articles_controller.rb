class ArticlesController < ApplicationController
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
