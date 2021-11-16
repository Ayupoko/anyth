require 'test_helper'

class Admin::SpacesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_spaces_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_spaces_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_spaces_edit_url
    assert_response :success
  end

  test "should get new" do
    get admin_spaces_new_url
    assert_response :success
  end

end
