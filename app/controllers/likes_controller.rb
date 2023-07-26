class LikesController < ApplicationController
  def create
    @like = Like.new
    @like.author = current_user
    @like.post = Post.find(params[:post_id])

    if Like.exists?(author: current_user, post: @like.post)
      existing_like = Like.find_by(author: current_user, post: @like.post)
      existing_like.destroy
    else
      @like.save!
    end

    redirect_to user_post_path(@like.author, @like.post)
  end
end
