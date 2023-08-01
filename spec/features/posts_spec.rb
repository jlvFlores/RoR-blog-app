require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before do
    @user = User.create(name: 'Tom', photo: 'tom.png')
    @second_user = User.create(name: 'Lilly', photo: 'lilly.png')
    @post = Post.create(author: @user, title: 'title1', text: 'Lorem ipsum 1')

    @comment1 = Comment.create(author: @user, post: @post, text: 'Text 1')
    @comment2 = Comment.create(author: @second_user, post: @post, text: 'Text 2')
    @comment3 = Comment.create(author: @user, post: @post, text: 'Text 3')
    @comment4 = Comment.create(author: @second_user, post: @post, text: 'Text 4')
    @comment5 = Comment.create(author: @user, post: @post, text: 'Text 5')
    @comment6 = Comment.create(author: @second_user, post: @post, text: 'Text 6')
  end

  context 'index page' do
    before { visit user_posts_path(@user) }

    it "has the user's name, image and number of posts" do
      expect(page).to have_content(@user.name)
      expect(page).to have_selector("img[src$='#{@user.photo}']")
      expect(page).to have_content("Number of post: #{@user.posts_count}")
    end

    it "has the post's title, text, comments count and likes count" do
      expect(page).to have_content(@post.title)
      expect(page).to have_content(@post.text)
      expect(page).to have_content("Comments: #{@post.comments_count}, Likes: #{@post.likes_count}")
    end

    it "has post's recent comments" do
      @post.recent_comments.each do |comment|
        expect(page).to have_content("#{comment.author.name}: #{comment.text}")
      end
    end

    it 'has a pagination button' do
      expect(page).to have_selector("a:contains('Pagination')")
    end

    it 'redirects to the corresponding post page when clicking on the post anchor tag' do
      post_box_selector = ".post-box[href='/users/#{@user.id}/posts/#{@post.id}']"
      find(post_box_selector).click
      expect(page).to have_current_path(user_post_path(@user, @post))
    end
  end

  context 'show page' do
    before { visit user_post_path(@user, @post) }

    it "renders the post's body" do
      expect(page).to have_css('.post')
    end

    it "has the post's title, author, text, comments count and likes count" do
      expect(page).to have_content("#{@post.title} by: #{@post.author.name}")
      expect(page).to have_content(@post.text)
      expect(page).to have_content("Comments: #{@post.comments_count}, Likes: #{@post.likes_count}")
    end

    it "has post's comments" do
      @post.comments.each do |comment|
        expect(page).to have_content("#{comment.author.name}: #{comment.text}")
      end
    end
  end
end
