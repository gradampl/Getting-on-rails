# frozen_string_literal: true

require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe ArticlesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Article. As you add validations to Article, be sure to adjust the attributes here as well.
  login_user

  let(:valid_attributes) do
    { title: "Test title!", text: "This is a test text", user_id: User.last.id }
  end

  let(:valid_attributes_2) do
    { title: "Test title!_2", text: "This is a test text_2", user_id: User.last.id }
  end

  let(:not_valid_attributes) do
    { title: nil || (0..3).each { |i| i.times { 'a' } } || 41.times { 'a' }, text: nil || (0..4).each { |a| a.times { 'a' } } || 301.times { 'a' }, user_id: User.last.id }
  end

  let(:not_valid_attributes_2) do
    { title: "Test title!", text: "This is a test text", user_id: 100 }
  end

  let!(:article) { FactoryBot.create(:article, user_id: User.last.id) }

  describe "GET #index" do
    it "populates an array of articles" do
      get :index, params: {}
      expect(assigns(:articles)).to eq([article])
    end
    it "is successful" do
      get :index, params: {}
      expect(response).to be_successful # be_successful expects a HTTP Status code of 200
    end
    it "renders the :index view" do
      get :index, params: {}
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested article to @article" do
      get :show, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end
    it "is successful" do
      get :show, params: { id: article.id }
      expect(response).to be_successful
    end
    it "renders the :show view" do
      get :show, params: { id: article.id }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'assigns a new article to @article' do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end
  end

  describe 'POST #create' do
    context 'success' do
      it 'creates a new article' do
        expect do
          post :create, params: { article: valid_attributes }
        end.to change(Article, :count).by(1)
      end
      it 'redirects to the article_path' do
        post :create, params: { article: valid_attributes }
        expect(response).to redirect_to Article.last
      end
      it 'flashes the notice' do
        post :create, params: { article: valid_attributes }
        expect(flash[:notice]).to match('Article successfully created.')
      end
    end

    context 'failure' do
      it 'creates NO new article' do
        expect do
          post :create, params: { article: not_valid_attributes }
        end.to change(Article, :count).by(0)
      end
      it 'renders the template "new"' do
        post :create, params: { article: not_valid_attributes }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'success' do
      it 'locates the requested article' do
        put :update, params: { id: article.id, article: valid_attributes }
        expect(assigns(:article)).to eq(article)
      end
      it 'changes article attributes' do
        put :update, params: { id: article.id, article: valid_attributes_2 }
        article.reload
        expect(article.title).to eq('Test title!_2')
        expect(article.text).to eq('This is a test text_2')
      end
      it 'redirects to the updated article' do
        put :update, params: { id: article.id, article: valid_attributes_2 }
        expect(response).to redirect_to Article.last
      end
      it 'flashes the notice' do
        put :update, params: { id: article.id, article: valid_attributes_2 }
        expect(flash[:notice]).to match('Article successfully updated.')
      end
    end

    context 'failure' do
      it 'locates the requested article' do
        put :update, params: { id: article.id, article: valid_attributes }
        expect(assigns(:article)).to eq(article)
      end
      it 'does NOT change article attributes' do
        put :update, params: { id: article.id, article: not_valid_attributes }
        article.reload
        expect(article.title).to eq('test_title')
        expect(article.text).to eq('test_text')
      end
      it 'does NOT change other author\'s article attributes' do
        put :update, params: { id: article.id, article: not_valid_attributes_2 }
        article.reload
        expect(article.title).to eq('test_title')
        expect(article.text).to eq('test_text')
      end
      it 're-renders the template "edit"' do
        put :update, params: { id: article.id, article: not_valid_attributes }
        expect(response).to render_template :edit
      end
    end
  end
  describe 'DELETE destroy' do
    it "deletes the article" do
      expect do
        delete :destroy, params: { id: article.id }
      end.to change(Article, :count).by(-1)
    end
    it "redirects to #index" do
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to articles_path
    end
    it 'flashes the notice' do
      delete :destroy, params: { id: article.id }
      expect(flash[:notice]).to match('Article successfully destroyed.')
    end
  end
end
