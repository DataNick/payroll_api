require 'csv'
module Services
    class TimeReportUploader
        def self.report_id_from_uploaded_file(csv_file)
            csv_file.original_filename.scan(/\d+/)[0]
        end
    
        def self.process_csv_file(csv_file)
            # binding.pry
            report_id = report_id_from_uploaded_file(csv_file)
    
            CSV.foreach(csv_file.path, headers: true, header_converters: :symbol) do |row|
                job_group = JobGroup.find_by(group_code: row[:job_group])
                employee = Employee.find_or_create_by(employee_company_id: row[:employee_id])
                ActiveRecord::Base.transaction do
                    timesheet_entry = TimesheetEntry.create!(workday: row[:date], hours: row[:hours_worked],
                    employee: employee, job_group: job_group, report_id: report_id)
        
                #     period_start, period_end = calculate_pay_period(timesheet_entry.workday)
        
                #     payroll_entry = PayrollEntry.find_or_create_by!(employee_id: employee.id,
                #     pay_period_start: period_start, pay_period_end: period_end)
        
                #     payroll_entry.update!(accrued_wages: payroll_entry.accrued_wages + (timesheet_entry.hours_worked * timesheet_entry.job_group.hourly_wage))
                end
            end
        end
    
        def self.calculate_pay_period(date)
            month_start = date.beginning_of_month
            if (1..15).include?(date.day)
                [month_start, month_start + 14]
            else
                [month_start + 15, date.end_of_month]
            end  
        end
    end
end