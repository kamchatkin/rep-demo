require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get current_shop" do
    get api_current_shop_url
    assert_response :success
  end

end
