require "test_helper"

class Api::V1::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_posts_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_posts_url, params: { id: '1' }
    assert_response :success
  end

  test "should post create" do
    post api_v1_posts_url
    assert_response 403
  end
end
