class ArticlesController < ApplicationController
  before_filter :initialize_service

  # Actions assigned to routing

  # List of articles
  def index
    @articles = Article.all
  end

  # Show article
  def show
    @article = @article_service.find(params[:id])
    @comment = Comment.new()
  end

  # Form to create new article
  def new
    @article = Article.new()
  end

  # Action to create new article
  def create
    @article_service.create_article(Article.new(params[:article]))
  end

  # Callbacks from service call

  # Callback after article was created
  def article_created(article)
    respond_to do |format|
      format.html { redirect_to root_path}
    end
  end

  # Callback after article was NOT created
  def article_create_error(article)
    @article = article
    respond_to do |format|
      format.html { render 'new' }
    end
  end

  # Callback when article was not found
  def article_not_found(article_id)
    Rails.logger.info("try to show missing article with id: #{article_id}.")
    redirect_to root_path
  end

  private

  def initialize_service
    @article_service = ArticleService.new(self)
  end
end
