require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test 'show display title' do
    idea = Idea.new title: 'Camping with LR Defender',
                    done_count: 34,
                    photo_url: 'https://cdn.pixabay.com/photo/2021/01/14/20/28/camper-5917855__340.jpg',
                    user: User.new
    idea.save!

    visit(idea_path(idea))
    sleep(3.seconds)
    assert page.has_content?('Camping with LR Defender')
    assert page.has_content?('34 have done')
    assert page.has_content?(idea.created_at.strftime("%d %b '%y"))
    sleep(7.seconds)

    click_on('Edit')

    assert_equal current_path, edit_idea_path(idea)
  end
end
