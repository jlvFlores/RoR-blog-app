require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'Jose') }
  let(:first_post) { Post.create(author: subject, title: 'first_post', text: 'Lorem ipsum') }
  let(:second_post) { Post.create(author: subject, title: 'second_post', text: 'Lorem ipsum') }
  let(:third_post) { Post.create(author: subject, title: 'third_post', text: 'Lorem ipsum') }
  let(:forth_post) { Post.create(author: subject, title: 'forth_post', text: 'Lorem ipsum') }

  context '#data' do
    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    context 'post_count' do
      it 'should NOT be less than zero' do
        subject.posts_count = -1
        expect(subject).to_not be_valid
      end

      it 'should be greater than or equal to zero' do
        subject.posts_count = 0
        expect(subject).to be_valid

        subject.posts_count = 1
        expect(subject).to be_valid
      end

      it 'should be an interger' do
        subject.posts_count = 0.5
        expect(subject).to_not be_valid
      end

      it 'should equal the amount of post created' do
        first_post
        second_post
        third_post
        forth_post
        expect(subject.posts_count).to eq(Post.all.size)
      end
    end
  end

  context '#methods' do
    it 'recent_posts returns the three most recent posts' do
      first_post
      second_post
      third_post
      forth_post
      expect(subject.recent_posts).to eq([forth_post, third_post, second_post])
    end
  end
end
