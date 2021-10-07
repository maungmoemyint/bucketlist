require 'test_helper'

class RolesHelperTest < ActionView::TestCase
  attr_accessor :current_user

  test 'idea can be edited by owner' do
    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    self.current_user = owner
    idea = Idea.create(title: 'A test idea', user: owner)

    assert can_edit?(idea)
  end

  test 'idea can be edited by an admin' do
    admin = User.create(email: 'admin@epfl.ch', password: 'password', role: 'admin')
    self.current_user = admin

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    idea = Idea.create(title: 'A test idea', user: owner)

    assert can_edit?(idea)
  end

  test 'idea cannot be edit by another user' do
    other = User.create(email: 'other@epfl.ch', password: 'password')
    self.current_user = other

    owner = User.create(email: 'owner@epfl.ch', password: 'password')
    idea = Idea.create(title: 'A test idea', user: owner)

    refute can_edit?(idea)
  end
end
