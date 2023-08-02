class Api::PostsController < ApplicationController
  def comments
    @post = Post.find(params[:id])
    render json: { comments: @post.comments }
  end

  def add_comment
    @post = Post.find(params[:id])
    @comment = @post.comments.build(text: params[:text])
    @comment.author = current_user

    if @comment.save
      render json: { message: 'Comment added successfully' }, status: :created
    else
      render json: { error: 'Failed to add comment' }, status: :unprocessable_entity
    end
  end
end
