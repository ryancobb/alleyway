require 'test_helper'

class SeleniumControllerTest < ActionDispatch::IntegrationTest
  test "should get run" do
    get selenium_run_url
    assert_response :success
  end

end
