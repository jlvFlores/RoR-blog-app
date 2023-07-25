require 'rails_helper'

RSpec.describe 'Users', type: :request do
  subject { User.create(name: 'Jose') }
  before { subject }

  context 'GET /index' do
    before { get users_path }

    it 'renders a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    it "includes placeholder text in the response's body" do
      expect(response.body).to include(subject.name)
    end
  end

  context 'GET /show' do
    before { get user_path(subject.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it "includes placeholder text in the response's body" do
      expect(response.body).to include(subject.name)
    end
  end
end
