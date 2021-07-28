require 'application_system_test_case'

Capybara.run_server = false

class CapybaraTest < ApplicationSystemTestCase
  test 'capybara works' do
    visit('http://www.duckduckgo.com')
    sleep(5.seconds)
    fill_in('q', with: 'Cinque Terre')
    sleep(5.seconds)
    click_on('S', match: :first)
    click_on('Wikipedia', match: :first)
    sleep(5.seconds)
    click_on('Manarola', match: :first)
    sleep(20.seconds)
  end
end
