require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.create(name: 'Jose', posts_count: 0) }
  let(:post) { Post.create(author:, title: 'title', comments_count: 0, likes_count: 0) }

  subject { described_class.new(author:, post:) }

  context '#data' do
    it 'should be valid with a post and user' do
      expect(subject).to be_valid
    end

    it 'should be invalid without a user' do
      subject.author = nil
      expect(subject).to_not be_valid
    end

    it 'should be invalid without a post' do
      subject.post = nil
      expect(subject).to_not be_valid
    end
  end
end
