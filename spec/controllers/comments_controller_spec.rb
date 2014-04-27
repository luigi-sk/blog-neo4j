require 'spec_helper'

describe CommentsController do
  describe 'can create comment' do
    it 'should check errors' do
      a = Article.new({ title: 'test article', text_content: 'lorem ipsum...' })
      a.save
      size = a.comments.to_a.size
      post 'create', { article_id: a.id }
      (size == a.comments.to_a.size).should be_true
      response.should be_success
    end

    it 'should create new comment' do
      a = Article.new({ title: 'test article', text_content: 'lorem ipsum...' })
      a.save
      size = a.comments.to_a.size
      post 'create', { article_id: a.id, comment: { author: 'test',
                                                    text_content: 'lorem ipsum comment..' }}
      ( Article.find(a.id).comments.to_a.size - size).should eq(1)
      response.should be_redirect
    end
  end
end
