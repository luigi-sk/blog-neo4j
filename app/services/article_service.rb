class ArticleService
  def initialize(listener)
    @listener = listener
    [:article_created, :article_create_error, :article_not_found].each do |m|
      unless @listener.respond_to?(m)
        raise NotImplementedError.new("missing method #{m} in #{listener.class.name}")
      end
    end
  end

  def create_article(article)
    if article.save
      @listener.article_created(article)
    else
      @listener.article_create_error(article)
    end
  end

  def find(article_id)
    article = Article.find(article_id)
    if article.nil?
      @listener.article_not_found(article_id)
      nil
    else
      article
    end
  end
end