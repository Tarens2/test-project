require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should login" do
    post api_v1_login_url
    assert_response 401
  end
end
