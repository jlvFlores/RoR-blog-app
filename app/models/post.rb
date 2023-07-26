class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  has_many :comments
  has_many :likes

  after_save :update_user_posts_count

  validates :title, presence: true, length: { maximum: 250 }
  validates :text, presence: true
  validates :comments_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    Comment.where(post_id: id).order(created_at: :desc).limit(5)
  end

  private

  def update_user_posts_count
    author.update(posts_count: author.posts.count)
  end
end
