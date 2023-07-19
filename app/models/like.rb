class Like < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User'

  after_save :update_post_likes_count

  private

  def update_post_likes_count
    post.update(likes_count: post.likes.count)
  end
end
