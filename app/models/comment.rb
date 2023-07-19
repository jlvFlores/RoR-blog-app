class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :author, class_name: 'User'

  after_save :update_post_comments_count

  private

  def update_post_comments_count
    post.update(comments_count: post.comments.count)
  end
end
