class Article < Neo4j::Rails::Model
  include ActiveModel::Validations

  property :title, type: String
  property :text_content, type: String
  property :published_at, type: DateTime

  has_n :comments

  validates_presence_of :title
end
