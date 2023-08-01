require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  before do
    @user1 = User.create(name: 'Tom', photo: 'tom.png', bio: 'I am thomas')
    @user2 = User.create(name: 'Lilly', photo: 'lilly.png', bio: 'I am lilith')
  end

  context 'index page' do
    before { visit users_path }

    it 'has the names, images and number of posts of all users' do
      User.all.each do |user|
        expect(page).to have_content(user.name)
        expect(page).to have_selector("img[src$='#{user.photo}']")
        expect(page).to have_content("Number of post: #{user.posts_count}")
      end
    end

    it 'redirects to the corresponding user page when clicking on the anchor tag' do
      User.all.each do |user|
        user_box_selector = ".user-box[href='/users/#{user.id}']"
        find(user_box_selector).click
        expect(page).to have_current_path(user_path(user))
        visit users_path
      end
    end
  end

  context 'show page' do
    before do
      @post1 = Post.create(author: @user1, title: 'title1', text: 'Lorem ipsum 1')
      @post2 = Post.create(author: @user1, title: 'title2', text: 'Lorem ipsum 2')
      @post3 = Post.create(author: @user1, title: 'title3', text: 'Lorem ipsum 3')
      @post4 = Post.create(author: @user1, title: 'title4', text: 'Lorem ipsum 4')

      visit user_path(@user1)
    end

    it "has the user's name, image, number of posts and bio" do
      expect(page).to have_content(@user1.name)
      expect(page).to have_selector("img[src$='#{@user1.photo}']")
      expect(page).to have_content("Number of post: #{@user1.posts_count}")
      expect(page).to have_content(@user1.bio)
    end

    it "has only the user's three most recent post" do
      @user1.recent_posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.text)
        expect(page).to have_content("Comments: #{post.comments_count}, Likes: #{post.likes_count}")
      end
    end

    it "has a button that redirects to all user's posts" do
      expect(page).to have_selector("a:contains('See all post')")

      click_link 'See all post'

      expect(page).to have_current_path(user_posts_path(@user1))
    end

    it 'redirects to the corresponding post page when clicking on the post anchor tag' do
      post_box_selector = ".post-box[href='/users/#{@user1.id}/posts/#{@post4.id}']"
      find(post_box_selector).click
      expect(page).to have_current_path(user_post_path(@user1, @post4))
    end
  end
end
