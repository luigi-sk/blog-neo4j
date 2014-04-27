require 'neo4j-core'

class ArticleCommentsService
  def initialize(article, listener)
    @article = article
    @listener = listener
    [:comment_created, :comment_create_error].each do |m|
      raise NotImplementedError.new("missing method #{m} in #{@listener.class.name}") unless @listener.respond_to?(m)
    end
  end

  def create_comment(comment)
    begin
      Neo4j::Transaction.run do
        comment.save
        @article.comments << comment
        @article.save
        Rails.logger.debug("ArticleCommentsService::create_comment #{@article.id} << #{comment.id}")
        raise ArgumentError.new("comment invalidate") if comment.errors.any?
      end
      Rails.logger.debug('ArticleCommentsService::create_comment transaction OK')
      @listener.comment_created(comment)
      return comment
    rescue => e
      @listener.comment_create_error(comment)
      return comment
    end
  end
end