require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    user = User.new email: 'test@epfl.ch', password: 'password'
    user.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')

    visit(new_idea_path)
    sleep(3.seconds)
    fill_in('Title', with: 'See the Matterhorn')
    sleep(3.seconds)
    fill_in('Done count', with: 120)
    sleep(3.seconds)
    fill_in('Photo url', with: "https://cdn.pixabay.com/photo/2016/07/14/13/35/mountains-1516733__340.jpg")
    sleep(3.seconds)
    click_on('Create Idea')
    sleep(3.seconds)
    visit(ideas_path)
    sleep(3.seconds)
    assert page.has_content?('See the Matterhorn')
    sleep(3.seconds)
    visit(ideas_path)
    sleep(3.seconds)

  end

  test 'index loads ideas' do
    first_idea = Idea.new title: 'Cycle across Swiss Jura',
                          done_count: 56,
                          photo_url: 'https://cdn.pixabay.com/photo/2014/07/05/08/18/bicycle-384566__340.jpg',
                          user: User.new
    first_idea.save!

    second_idea = Idea.new title: 'Sailing in the Geneva lake',
                          done_count: 150,
                          photo_url: 'https://cdn.pixabay.com/photo/2016/12/18/14/31/lake-1915846__340.jpg',
                          user: User.new
    second_idea.save!

    visit (ideas_path)
    sleep(3.seconds)
    assert page.has_content?('Cycle across Swiss Jura')
    sleep(3.seconds)
    assert page.has_content?('Sailing in the Geneva lake')
    sleep(3.seconds)
    visit (ideas_path)
    sleep(3.seconds)

  end

  test 'editing an idea' do
    user = User.new email: 'new@epfl.ch', password: 'password'
    idea = Idea.new title: 'Unedited idea', user: user
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Done count', with: 73)
    fill_in('Title', with: 'Learn Ruby on Rails')
    click_on('Update')
    click_on('Learn Ruby on Rails')
    assert page.has_content?('Learn Ruby on Rails')
    assert page.has_content?('73 have done this')
  end

  test 'search' do
    idea_1 = Idea.new title: 'Climb Mont Blanc',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Visit Niagara Falls',
                      user: User.new
    idea_2.save!
    visit(root_path)
    fill_in('q', with: 'Mont')
    click_on('Search', match: :first)
    assert current_path.include?(ideas_path)
    assert page.has_content?('Climb Mont Blanc')
    refute page.has_content?('Visit Niagra Falls')
  end

  test 'no search results' do
    visit(ideas_path)
    assert page.has_content?('No ideas found!')
  end

  test 'homepage highlights' do
    4.times do |i|
      idea= Idea.new title: "Exciting Idea #{i+1}",
                     user: User.new
      idea.save!
    end

    visit(root_path)
    sleep(5.seconds)

    assert page.has_content?('Exciting Idea 4')
    assert page.has_content?('Exciting Idea 3')
    assert page.has_content?('Exciting Idea 2')
    refute page.has_content?('Exciting Idea 1')
  end

  test 'search by description and title' do
    idea_1 = Idea.new title: "Go cycling across Europe",
                      description: "An amazing wayto see lots of Europe",
                      user: User.new
    idea_1.save!

    idea_2 = Idea.new title: "Visit Provence",
                      description: "Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender",
                      user: User.new
    idea_2.save!

    idea_3 = Idea.new title: "Overnight hike in Switzerland",
                      description: "Stay in a Swiss refuge in the mountains",
                      user: User.new
    idea_3.save!

    visit(root_path)

    fill_in('q', with: 'cycling')
    click_on('Search', match: :first)

    sleep(7.seconds)

    assert page.has_content?('Go cycling across Europe')
    assert page.has_content?('Visit Provence')
    refute page.has_content?('Overnight hike in Switzerland')
  end

  test 'new idea with no title' do
    user = User.new email: 'test@epfl.ch', password: 'password'
    user.save!

    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)
    click_on('Log in')


    visit(new_idea_path())
    fill_in('Done count', with: 635)
    click_on ('Create Idea')
    assert page.has_content?("Title can't be blank")
  end

  test 'existing idea updated with no title' do
    idea = Idea.new title: 'Exciting idea',
                    user: User.new
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Title', with: '')
    click_on ('Update Idea')
    assert page.has_content?("Title can't be blank")
  end
end
