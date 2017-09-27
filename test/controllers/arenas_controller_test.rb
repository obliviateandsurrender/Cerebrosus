require 'test_helper'

class ArenasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get arenas_index_url
    assert_response :success
  end

  test "should get quiz" do
    get arenas_quiz_url
    assert_response :success
  end

  test "should get result" do
    get arenas_result_url
    assert_response :success
  end

end
