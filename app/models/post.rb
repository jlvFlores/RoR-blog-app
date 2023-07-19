class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  has_many :comments
  has_many :likes

  after_save :update_user_posts_count

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_count
    author.update(posts_count: author.posts.count)
  end
end
