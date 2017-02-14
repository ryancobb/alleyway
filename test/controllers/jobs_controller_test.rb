require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  test "should get status" do
    get jobs_status_url
    assert_response :success
  end

end
