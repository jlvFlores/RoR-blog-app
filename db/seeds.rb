# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom', photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://media.istockphoto.com/id/520225266/es/foto/lilium-naranja-flor.jpg?s=1024x1024&w=is&k=20&c=kCQKET-01wzL06e8tDpNalpouQyGDiaHAvFhDcvq-zQ=', bio: 'Teacher from Poland.')

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Hello again', text: 'This is my second post')
third_post = Post.create(author: first_user, title: 'How are you?', text: 'This is my third post')
forth_post = Post.create(author: first_user, title: 'My name is..', text: 'This is my forth post')
fifth_post = Post.create(author: second_user, title: 'Lilly, the blogger', text: 'This is my first post')

Comment.create(post: first_post, author: second_user, text: 'Hi Tom!' )
Comment.create(post: first_post, author: first_user, text: 'Hey Lilly!' )
Comment.create(post: first_post, author: second_user, text: 'Nice post!' )
Comment.create(post: first_post, author: first_user, text: 'Thanks!' )
Comment.create(post: first_post, author: second_user, text: 'How have you been?' )
Comment.create(post: first_post, author: first_user, text: 'Ive been well' )

Like.create(post: first_post, author: first_user)