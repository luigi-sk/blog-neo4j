require 'spec_helper'

describe ArticlesController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "can show form for create" do
    it "should http succ" do
      get 'new'
      response.should be_success
    end
  end

  describe "can create new article" do
    it "should redirect if success" do
      size = Article.all.to_a.size
      post 'create', { article: { title: 'test article', text_content: 'lorem ipsum...' } }
      response.should be_redirect
      new_size = Article.all.to_a.size
      (new_size - size).should eq(1)
    end

    it "should show same page if error" do
      size = Article.all.to_a.size
      post 'create', { article: { title: '', text_content: 'lorem ipsum...' } }
      response.should be_success
      new_size = Article.all.to_a.size
      (new_size - size).should eq(0)
    end
  end

  describe "can show article" do
    it "should show article" do
      a = Article.new({ title: 'test article', text_content: 'lorem ipsum...' })
      a.save
      get 'show', { id: a.id }
      response.should be_success
    end

    it "should be redirect if missing article" do
      get 'show', { id: -1 }
      response.should be_redirect
    end

  end

end
