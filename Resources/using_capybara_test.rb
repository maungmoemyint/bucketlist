require 'application_system_test_case'

Capybara.run_server = false

class CapybaraTest < ApplicationSystemTestCase
  test 'capybara works' do
    visit('https://duckduckgo.com/)
    sleep(5.seconds)
    fill_in('q', with: 'Ruby on Rails')
    sleep(5.seconds)
    click_on('Search', match: :first)
    click_on('Ruby on Rails', match: :first)
    sleep(5.seconds)
    click_on('Guides')
    sleep(20.seconds)
  end
end
