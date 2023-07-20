require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'Jose', posts_count: 0) }

  subject { described_class.create(author:, title: 'title', comments_count: 0, likes_count: 0) }

  let(:first_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:second_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:third_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:forth_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:fifth_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:sixth_comment) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }

  let(:first_like) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }
  let(:second_like) { Comment.create(post: subject, author:, text: 'Lorem ipsum') }

  context '#title' do
    it 'should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'should not exceed 250 characters' do
      subject.title = 'a' * 250
      expect(subject).to be_valid

      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end
  end

  context '#comments_count' do
    it 'should NOT be less than zero' do
      subject.comments_count = -1
      expect(subject).to_not be_valid
    end

    it 'should be an greater than or equal to zero' do
      subject.comments_count = 0
      expect(subject).to be_valid

      subject.comments_count = 1
      expect(subject).to be_valid
    end

    it 'should be an interger' do
      subject.comments_count = 0.5
      expect(subject).to_not be_valid
    end

    it 'should equal the amount of comments created' do
      first_comment
      second_comment
      third_comment
      expect(subject.comments_count).to eq(Comment.all.size)
    end
  end

  context '#likes_count' do
    it 'should NOT be less than zero' do
      subject.likes_count = -1
      expect(subject).to_not be_valid
    end

    it 'should be an greater than or equal to zero' do
      subject.likes_count = 0
      expect(subject).to be_valid

      subject.likes_count = 1
      expect(subject).to be_valid
    end

    it 'should be an interger' do
      subject.likes_count = 0.5
      expect(subject).to_not be_valid
    end

    it 'should equal the amount of likes created' do
      first_like
      second_like
      expect(subject.likes_count).to eq(Like.all.size)
    end
  end

  context '#methods' do
    it 'recent_comments returns the five most recent comments' do
      first_comment
      second_comment
      third_comment
      forth_comment
      fifth_comment
      sixth_comment
      recent_comments_array = [sixth_comment, fifth_comment, forth_comment, third_comment, second_comment]
      expect(subject.recent_comments).to eq(recent_comments_array)
    end
  end
end
