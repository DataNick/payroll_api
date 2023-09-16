require "test_helper"

class PayrollReportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get payroll_report_index_url
    assert_response :success
  end

  test "should get new" do
    get payroll_report_new_url
    assert_response :success
  end

  test "should get create" do
    get payroll_report_create_url
    assert_response :success
  end
end
