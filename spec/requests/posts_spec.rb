require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  subject { User.create(name: 'Jose') }
  let(:post) { Post.create(author: subject, title: 'New post', text: 'Lorem ipsum') }

  before do
    post
    subject
  end

  context 'GET /index' do
    before { get user_posts_path(subject.id) }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it "includes placeholder text in the response's body" do
      expect(response.body).to include(post.title)
    end
  end

  context 'GET /show' do
    before { get user_post_path(subject.id, post.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it "includes placeholder text in the response's body" do
      expect(response.body).to include(post.title)
    end
  end
end
