module Services
    class PayrollReportGenerator
        def self.generate_report
            Employee.all.each do |employee|
                employee.timesheet_entries.each do |ts|
                    pay_date = ts.workday
                    hourly_wage = ts.job_group.hourly_wage
                    hours = ts.hours 
                    current_wages = (hourly_wage * hours)                    
                    employee_report = EmployeeReport.find_or_create(employee.employee_company_id, pay_date)
                    old_amount =  BigDecimal(employee_report.format_price)
                    new_amount = BigDecimal(current_wages)                     
                    new_amount = employee_report.calculate_price(old_amount, new_amount)
                    employee_report.amountPaid = new_amount
                end
            end
            EmployeeReport::EMPLOYEE_REPORTS
        end
    
    end
end