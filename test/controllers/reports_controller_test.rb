require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get daily" do
    get :daily
    assert_response :success
  end

  test "should get monthly" do
    get :monthly
    assert_response :success
  end

  test "should get monthToDate" do
    get :monthToDate
    assert_response :success
  end

end
