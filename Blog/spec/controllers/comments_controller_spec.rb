# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  login_user

  let!(:comment_valid_attributes) do
    { commenter: "Test commenter!", body: "This is a test body" }
  end
  let(:not_comment_valid_attributes) do
    { commenter: nil || (0..2).each { |i| i.times { 'a' } } || 21.times { 'a' }, body: nil || (0..4).each { |a| a.times { 'a' } } || 301.times { 'a' } }
  end

  let!(:article) { FactoryBot.create(:article, user_id: User.last.id) }
  let!(:comment) { FactoryBot.create(:comment, article_id: article.id) }

  describe 'POST #create' do
    context 'success' do
      it 'creates a new comment' do
        expect do
          post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        end.to change(Comment, :count).by(1)
      end
      it 'assigns comment to correct article' do
        post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        expect(assigns(:comment).article_id).to eq(article.id)
      end
      it 'redirects to the article_path' do
        post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        expect(response).to redirect_to article_path(article.id)
      end
      it 'flashes the notice' do
        post :create, params: { comment: comment_valid_attributes, article_id: article.id }
        expect(flash[:notice]).to match('Comment successfully created.')
      end
    end

    context 'failure' do
      it 'creates NO new comment' do
        expect do
          post :create, params: { comment: not_comment_valid_attributes, article_id: article.id }
        end.to change(Comment, :count).by(0)
      end
      it 'redirects to the article_path' do
        post :create, params: { comment: not_comment_valid_attributes, article_id: article.id }
        expect(response).to redirect_to article_path(article.id)
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the comment" do
      expect do
        delete :destroy, params: { id: comment.id, article_id: article.id }
      end.to change(article.comments, :count).by(-1)
    end

    it 'redirects to the article_path' do
      delete :destroy, params: { id: comment.id, article_id: article.id }
      expect(response).to redirect_to article_path(article.id)
    end
    it 'flashes the notice' do
      delete :destroy, params: { id: comment.id, article_id: article.id }
      expect(flash[:notice]).to match('Comment successfully destroyed.')
    end
  end
end
