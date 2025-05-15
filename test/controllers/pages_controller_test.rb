require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get about_us" do
    get pages_about_us_url
    assert_response :success
  end

  test "should get about_me" do
    get pages_about_me_url
    assert_response :success
  end

  test "should get join_us" do
    get pages_join_us_url
    assert_response :success
  end
end
