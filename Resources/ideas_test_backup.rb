require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test 'create new idea' do
    visit(new_idea_path)
    sleep(7.seconds)
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
    sleep(7.seconds)

  end

  test 'index loads ideas' do
    first_idea = Idea.new
    first_idea.title = 'Cycle across Swiss Jura'
    first_idea.done_count = 56
    first_idea.photo_url = 'https://cdn.pixabay.com/photo/2014/07/05/08/18/bicycle-384566__340.jpg'
    first_idea.save!

    second_idea = Idea.new
    second_idea.title = 'Sailing in the Geneva lake'
    second_idea.done_count = 150
    second_idea.photo_url = 'https://cdn.pixabay.com/photo/2016/12/18/14/31/lake-1915846__340.jpg'
    second_idea.save!

    visit (ideas_path)
    sleep(3.seconds)
    assert page.has_content?('Cycle across Swiss Jura')
    sleep(3.seconds)
    assert page.has_content?('Sailing in the Geneva lake')
    sleep(3.seconds)
    visit (ideas_path)
    sleep(7.seconds)

  end

  test 'editing an idea' do
    idea = Idea.new title: 'Unedited idea'
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
    idea_1 = Idea.new
    idea_1.title = 'Climb Mont Blanc'
    idea_1.save!
    idea_2 = Idea.new
    idea_2.title = 'Visit Niagara Falls'
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
      idea= Idea.new
      idea.title = "Exciting Idea #{i+1}"
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
    idea_1 = Idea.new
    idea_1.title = "Go cycling across Europe"
    idea_1.description = "An amazing wayto see lots of Europe"
    idea_1.save!

    idea_2 = Idea.new
    idea_2.title = "Visit Provence"
    idea_2.description = "Go to vineyards, go cycling up Mont Ventoux, see the fields of lavender"
    idea_2.save!

    idea_3 = Idea.new
    idea_3.title = "Overnight hike in Switzerland"
    idea_3.description = "Stay in a Swiss refuge in the mountains"
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
    visit(new_idea_path())
    fill_in('Done count', with: 635)
    click_on ('Create Idea')
    assert page.has_content?("Title can't be blank")
  end

  test 'existing idea updated with no title' do
    idea = Idea.new title: 'Exciting idea'
    idea.save!
    visit(edit_idea_path(idea))
    fill_in('Title', with: '')
    click_on ('Update Idea')
    assert page.has_content?("Title can't be blank")
  end
end
