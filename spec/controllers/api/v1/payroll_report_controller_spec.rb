require 'rails_helper'
RSpec.describe Api::V1::PayrollReportController do
    let(:job_group_a) { create(:job_group) }
    let(:job_group_b) { create(:job_group) }
    let(:csv_file) {fixture_file_upload(Rails.root+'time-report-42.csv','application/csv')}

    before (:each) do
        job_group_a
        job_group_b.hourly_wage = 30
        job_group_b.group_code = 'B'
        job_group_b.save
    end

    describe "POST create" do
        it "uploads a csv file" do
            post :create, params: {payroll_report: csv_file}
            parsed_response = JSON.parse(response.body)
            expect(parsed_response['message']).to eq('Successfully uploaded file.')
        end

        it "creates timesheet_entries" do
            post :create, params: {payroll_report: csv_file}
            parsed_response = JSON.parse(response.body)
            expect(TimesheetEntry.all.count).to eq(31)
        end
    end

    describe "GET index" do
        it "creates EmployeeReports" do
            post :create, params: {payroll_report: csv_file}
            post :index
            parsed_response = JSON.parse(response.body)
            EmployeeReport::EMPLOYEE_REPORTS.each{|er| puts "#{er.employeeId}: #{er.amountPaid} || #{er.payPeriod}"}
            expect(EmployeeReport::EMPLOYEE_REPORTS.count).to eq(13)
        end
    end
  end