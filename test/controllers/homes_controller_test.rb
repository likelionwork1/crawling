require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get homes_index_url
    assert_response :success
  end

  test "should get navertv" do
    get homes_navertv_url
    assert_response :success
  end

  test "should get navercafe" do
    get homes_navercafe_url
    assert_response :success
  end

  test "should get daumcafe" do
    get homes_daumcafe_url
    assert_response :success
  end

end
