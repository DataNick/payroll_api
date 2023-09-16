class EmployeeReport
    # include ActiveModel::Model
    attr_accessor :payPeriod, :employeeId, :amountPaid 
    
    EMPLOYEE_REPORTS = []
    def initialize(pay_date, employee_id)
        @employeeId = employee_id
        @payPeriod = EmployeeReport.calculate_pay_period(pay_date)
        @amountPaid = "$#{BigDecimal(0)}"        
    end

    def format_price
        @amountPaid.gsub('$', '')
    end

    def to_camel
        self.split(/_/).map(&:capitalize).join
    end

    def self.find_or_create(employee_id, date)
        # binding.pry
        pay_period = calculate_pay_period(date)
        returned_object = EMPLOYEE_REPORTS.find{|pe| (pe.employeeId == employee_id) && (pe.payPeriod == pay_period)}
        unless returned_object
            # binding.pry
            returned_object = EmployeeReport.new(pay_period[:startDate], employee_id)
            EMPLOYEE_REPORTS << returned_object
        end
        returned_object
    end

    def calculate_price(old_price, new_price)
        new_amount = old_price + new_price
        updated_price = sprintf('%.2f', new_amount)
        updated_price = "$" + updated_price
    end

    def self.calculate_pay_period(date)        
        month_start = date.beginning_of_month
        if (1..15).include?(date.day)
            {startDate: month_start, endDate: month_start + 14}
        else
            {startDate: month_start + 15, endDate: date.end_of_month}
        end  
    end
end