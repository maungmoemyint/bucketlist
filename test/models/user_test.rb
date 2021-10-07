require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'email is lower case before validation' do
    user = User.new email: 'TnEw@EpFL.Ch', password: 'password'
    user.save!
    assert_equal 'tnew@epfl.ch', user.email 
  end
end
