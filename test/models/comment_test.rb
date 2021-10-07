require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated idea for a comment'do
    user = User.new email: 'new@epfl.ch', password: 'password'
    idea = Idea.new title: 'Exciting idea!', user: user
    idea.save!

    comment = Comment.new body: "I`d liketo do this.", idea: idea
    comment.user = user
    comment.save!

    idea_2 = Idea.new title: 'Second exciting idea!', user: user
    idea_2.save!

    comment.idea = idea_2
    comment.save!

    assert_equal idea_2, Comment.first.idea
  end

  test 'cascading save' do
    user = User.new email: 'new@epfl.ch', password: 'password'
    idea = Idea.new title: 'Awesome idea!', user: user
    idea.save!

    comment = Comment.new body: "Great idea", user: user
    idea.comments << comment
    idea.save!

    assert_equal comment, Comment.first
  end

  test 'Comments are ordered correctly' do
    user = User.new email: 'new@epfl.ch', password: 'password'
    idea = Idea.new title: 'Idea for travelling', user: user
    idea.save!

    user1 = User.new email: 'new1@epfl.ch', password: 'password'
    comment_1 = Comment.new body:'This would be great fun', user: user1

    user2 = User.new email: 'new2@epfl.ch', password: 'password'
    comment_2 = Comment.new body: "I agree I`d like to do this as well", user: user2

    idea.comments << comment_1
    idea.comments << comment_2

    idea.save!

    assert_equal idea.comments.first, comment_1
    assert_equal 2, idea.comments.length

  end
end
