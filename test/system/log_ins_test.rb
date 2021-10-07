require "application_system_test_case"

class LogInsTest < ApplicationSystemTestCase
  test 'sign up create a user' do
    visit(new_user_path)
    fill_in('Email', with: 'newtest@epfl.ch')
    fill_in('Password', with: 'password')
    click_on('Sign up')
    assert_equal 1, User.all.length
    assert_equal 'newtest@epfl.ch', User.first.email
  end

  test 'log in does not create a user' do
    user = User.new email: 'existing@epfl.ch', password: 'password'
    user.save!
    visit(new_session_path)
    fill_in('email', with: user.email)
    fill_in('password', with: user.password)

    click_on('Log in')
    assert_equal 1, User.all.length
  end

end
