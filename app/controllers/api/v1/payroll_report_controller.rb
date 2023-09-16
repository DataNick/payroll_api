require 'services/payroll_report_generator'
require 'services/time_report_uploader'
class Api::V1::PayrollReportController < ApplicationController
  def index
    @employee_reports = Services::PayrollReportGenerator.generate_report
    @employee_reports =  @employee_reports.sort_by{ |er| [er.employeeId, er.payPeriod[:startDate]] }
  
    @employee_reports = {payrollReport: {employeeReports: @employee_reports}}
    render json: @employee_reports
  end

  def new
  end

  def create
    report_id = Services::TimeReportUploader.report_id_from_uploaded_file(time_report_params)
    
    if TimesheetEntry.where(report_id: report_id).exists?
      render json: {message: 'Failed to upload file.'}
    else
      Services::TimeReportUploader.process_csv_file(time_report_params)
      render json: {message: 'Successfully uploaded file.'}
    end
  end

  private
  def time_report_params
    params.require(:payroll_report)
  end
end
