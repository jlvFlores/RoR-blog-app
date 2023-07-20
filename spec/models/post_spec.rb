require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: "Jose", posts_count: 0) }

  subject { described_class.create(author: author, title: "title", comments_count: 0, likes_count: 0) }

  let(:comment_1) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }
  let(:comment_2) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }
  let(:comment_3) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }
  let(:comment_4) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }
  let(:comment_5) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }
  let(:comment_6) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }

  let(:like_1) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }
  let(:like_2) { Comment.create(post: subject, author: author, text: 'Lorem ipsum') }


  context '#data' do
    context 'title' do
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

    context 'comments_count' do
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
        comment_1
        comment_2
        comment_3
        expect(subject.comments_count).to eq(Comment.all.size)
      end
    end

    context 'likes_count' do
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
        like_1
        like_2
        expect(subject.likes_count).to eq(Like.all.size)
      end
    end
  end

  context '#methods' do
    it 'recent_comments returns the five most recent comments' do
      comment_1
      comment_2
      comment_3
      comment_4
      comment_5
      comment_6
      recent_comments_array = [comment_6, comment_5, comment_4, comment_3, comment_2]
      expect(subject.recent_comments).to eq(recent_comments_array)
    end
  end
end
