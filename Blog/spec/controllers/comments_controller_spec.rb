# frozen_string_literal: true

require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe CommentsController, type: :controller do
  let(:article_valid_attributes) do
    { title: "Test title!", text: "This is a test text", user_id: User.last.id }
  end

  let(:article) { Article.create(article_valid_attributes) }

  let(:comment_valid_attributes) do
    { commenter: "Test commenter!", body: "This is a test body" }
  end

  let(:not_comment_valid_attributes) do
    { commenter: nil || (0..2).each { |i| i.times { 'a' } } || 21.times { 'a' }, body: nil || (0..4).each { |a| a.times { 'a' } } || 301.times { 'a' } }
  end

  let(:valid_comment) { params comment_valid_attributes, article_id: article.id }

  let(:not_valid_comment) { params not_comment_valid_attributes, article_id: article.id }
  let(:comment) { Comment.create { valid_comment } }

  login_user

  describe 'POST #create' do
    context 'success' do
      it 'creates a new comment' do
        article
        expect do
          post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        end.to change(Comment, :count).by(1)
      end
      it 'assigns comment to correct article' do
        article
        post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        expect(assigns(:comment).article_id).to eq(article.id)
      end
      it 'redirects to the article_path' do
        article
        post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        expect(response).to redirect_to article_path(article.id)
      end
    end

    context 'failure' do
      it 'creates NO new comment' do
        article
        expect do
          post :create, params: { comment: not_comment_valid_attributes, article_id: article.id }
        end.to change(Comment, :count).by(0)
      end
      it 'redirects to the article_path' do
        article
        post :create, params: { comment: not_comment_valid_attributes, article_id: article.id }
        expect(response).to redirect_to article_path(article.id)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:article) { FactoryBot.create(:article) }
    # let(:comment) { FactoryBot.create(:comment, article_id: article.id) }

    let!(:comment) { article.comments.create(comment_valid_attributes) }

    it "deletes the comment" do
      # @article = FactoryBot.create(:article)
      # @comment = FactoryBot.create(:comment, article_id: @article.id)
      # article #= FactoryBot.create(:article)
      # comment = FactoryBot.create(:comment, article_id: article.id)

      expect do
        delete :destroy, params: { id: comment.id, article_id: article.id }
      end.to change(article.comments, :count).by(-1)
    end
    #   it 'redirects to the article_path' do
    # article
    # comment
    # expect do
    #   delete :destroy, params: { id: comment.id, article_id: article.id }
    # end.to redirect_to article_path(article.id)
    #   delete :destroy, params: { id: comment.id, article_id: article.id }
    #   expect(response).to redirect_to article_path(article.id)
    # end
    # it 'flashes the notice' do
    #   delete :destroy, params: { id: article.id }
    #   expect(flash[:notice]).to match('Article successfully destroyed.')
    # end
  end
end
