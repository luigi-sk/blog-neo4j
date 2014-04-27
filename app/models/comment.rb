class Comment < Neo4j::Rails::Model
  include ActiveModel::Validations
  property :author, type: String
  property :text_content, type: String

  validates_presence_of :author
end