require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get g" do
    get welcome_g_url
    assert_response :success
  end

  test "should get controller" do
    get welcome_controller_url
    assert_response :success
  end

  test "should get welcome" do
    get welcome_welcome_url
    assert_response :success
  end

end
