class CommentsController < ApplicationController
  before_filter :initialize_service

  # Action to create new comment assigned to article
  def create
    comment = Comment.new(params[:comment])
    @articles_comments_service.create_comment(comment)
  end

  # Callbacks from service

  # Callback after comment created successfully
  def comment_created(comment)
    Rails.logger.info("Comment was created")
    @comments = [comment]
    respond_to do |format|
      format.html { redirect_to article_path(@article.id) }
      format.js
    end
  end

  # Callback after comment was NOT created
  def comment_create_error(comment)
    Rails.logger.info("Comment was NOT created")
    @comment = comment
    respond_to do |format|
      format.html { render 'articles/show' }
      format.js { render 'create_error' }
    end

  end

  private

  def initialize_service
    @article = Article.find(params[:article_id])
    if @article.nil?
      redirect_to :root_path
      return false
    end
    @articles_comments_service = ArticleCommentsService.new(@article, self)
  end
end
