require 'test_helper'

class IdeaTest < ActiveSupport::TestCase

# Idea.all.each do |idea|
#   idea.destroy
# end

  test 'the first empty Idea created is first in the list' do
    
    first_idea = Idea.new title: 'First idea', user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'Second idea', user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'the first complete Idea created is first in the list' do
    first_idea = Idea.new title: 'Cycle the length of the United Kingdom',
                          photo_url: 'http://mybucketlist.ch/an_image.jpg',
                          done_count: 12,
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'Visit Japan',
                           photo_url: 'http://mybucketlist.ch/second_image.jpg',
                           done_count: 3,
                           user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test 'updated_at is changed after updating title' do
    idea = Idea.new title: 'Visit Marrakech',
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.title = 'Visit the market in Marrakech'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating done_count' do
    idea = Idea.new title: 'Create production in Switzerland',
                    done_count: 46,
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.done_count = 184
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'updated_at is changed after updating photo_url' do
    idea = Idea.new title: 'Intersting idea for sport',
                    photo_url: '/images/swimmers.jpg',
                    user: User.new
    idea.save!
    first_updated_at = idea.updated_at
    idea.photo_url = '/images/runners.jpg'
    idea.save!
    refute_equal(idea.updated_at, first_updated_at)
  end

  test 'changing the title' do
    idea = Idea.new title: 'Cycle across Swiss Jura',
                    user: User.new
    idea.save!
    updated_at = idea.updated_at
    idea.title = 'Drive across Switzerland'
    assert idea.save
    refute_equal idea.updated_at, updated_at
  end

  test 'removing the title' do
    idea = Idea.new title: 'Cycle across Swiss Jura',
                    user: User.new
    idea.save!
    updated_at = idea.updated_at
    idea.title = 'No title'
    assert idea.save
    refute_equal idea.updated_at, updated_at
  end

  test 'One matching result' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    idea.save!
    assert_equal Idea.search('the top').length, 1
  end

  test 'No matching results' do
    idea = Idea.new title: 'Stand at the top of the Empire State Building',
                    user: User.new
    idea.save!
    assert_equal Idea.search('snorkelling').length, 0
  end

  test 'Two matching results' do
    idea_1 = Idea.new title: 'Stand at the top of the Empire State Building',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Stand on the pyramids',
                      user: User.new
    idea_2.save!
    assert_equal Idea.search('Stand').length, 2
  end

  test 'most_recent with no Ideas' do
    assert_empty Idea.most_recent
  end

  test 'most_recent with two ideas' do
    idea_1 = Idea.new title: 'Exciting idea 1',
                      user: User.new
    idea_1.save!
    idea_2 = Idea.new title: 'Exciting idea 2',
                      user: User.new
    idea_2.save!

    assert_equal Idea.most_recent.length, 2
    assert_equal Idea.most_recent.first, idea_2
  end

  test 'most_recent with six ideas' do
    6.times do |i|
      idea= Idea.new title: "Exciting idea #{i+1}",
                     user: User.new
      idea.save!
    end
    assert_equal Idea.most_recent.length, 3
    assert_equal Idea.most_recent.first.title, "Exciting idea 6"
  end

  test 'match with description' do
    idea = Idea.new title: "Surfing in Portugal",
                    description: "See what Atlantic coast waves are like!",
                    user: User.new
    idea.save!

    assert_equal 1, Idea.search('coast').length
  end

  test 'search with description and title match' do
    idea_1 = Idea.new title: "Overnight hike in Switzerland",
                      description: "Stay in a Swiss refuge in the mountains",
                      user: User.new
    idea_1.save!

    idea_2 = Idea.new title: "Hike the mountains in Italy",
                      description: "See the Dolomites and Italian Alps",
                      user: User.new
    idea_2.save!

    assert_equal 2, Idea.search('mountains').length
  end

  test 'maximum length of title' do
    idea = Idea.new title: 'An idea title that is far, far too long to be valid in the My bucket list application',
                    user: User.new
    refute idea.valid?
  end

  test 'presence of title' do
    idea = Idea.new
    refute idea.valid?
  end

end
