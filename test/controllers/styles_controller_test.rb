require 'test_helper'

class StylesControllerTest < ActionDispatch::IntegrationTest
  test "should get atoms" do
    get styles_atoms_url
    assert_response :success
  end

  test "should get molecules" do
    get styles_molecules_url
    assert_response :success
  end

  test "should get organisms" do
    get styles_organisms_url
    assert_response :success
  end

end
