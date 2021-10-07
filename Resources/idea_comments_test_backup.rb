require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test 'adding a comment to an Idea' do

    user = User.new email: 'test@epfl.ch'
    user.save!

    idea = Idea.new title: 'Volunteer for a charity'
    idea.save

    visit(new_user_path)
    fill_in('Email', with: user.email)
    click_on('Log in')

    visit(idea_path(idea))
    fill_in('Add a comment', with: 'This is a fantastic idea')
    click_on('Post', match: :first)

    assert_equal idea_path(idea), page.current_path
    assert page.has_content?('This is a fantastic idea')
  end

  test 'comments cannot be added when logged in' do
    idea = Idea.new title: 'Try archery'
    idea.save!
    visit(idea_path(idea))
    refute page.has_content?('Add a comment')
  end
end
