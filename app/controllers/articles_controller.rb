class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @articles_comments = @article.comments
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      flash[:alert] = 'There was an issue creating the article.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      flash[:alert] = 'There was an issue updating the article.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path, status: :see_other, notice: 'Article was successfully deleted.'
  rescue ActiveRecord::InvalidForeignKey
    redirect_to @article, alert: 'Cannot delete article. It is associated with other records.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: 'Article not found.'
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
