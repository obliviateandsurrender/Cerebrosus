require 'test_helper'

class LeaderboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get category" do
    get leaderboards_category_url
    assert_response :success
  end

  test "should get subcategory" do
    get leaderboards_subcategory_url
    assert_response :success
  end

  test "should get quiz" do
    get leaderboards_quiz_url
    assert_response :success
  end

end
