require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'changing the associated idea for a comment'do
    idea = Idea.new title: 'Exciting idea!'
    idea.user = User.new
    idea.save!

    comment = Comment.new body: "I`d liketo do this.", idea: idea
    comment.user = User.new
    comment.save!

    idea_2 = Idea.new title: 'Second exciting idea!'
    idea_2.user = User.new
    idea_2.save!

    comment.idea = idea_2
    comment.save!

    assert_equal idea_2, Comment.first.idea
  end

  test 'cascading save' do
    idea = Idea.new title: 'Awesome idea!', user: User.new
    idea.save!

    comment = Comment.new body: "Great idea", user: User.new
    idea.comments << comment
    idea.save!

    assert_equal comment, Comment.first
  end

  test 'Comments are ordered correctly' do
    idea = Idea.new title: 'Idea for travelling'
    idea.user = User.new
    idea.save!

    comment_1 = Comment.new body:'This would be great fun', user: User.new
    comment_2 = Comment.new body: "I agree I`d like to do this as well", user: User.new

    idea.comments << comment_1
    idea.comments << comment_2

    idea.save!

    assert_equal idea.comments.first, comment_1
    assert_equal 2, idea.comments.length

  end
end
