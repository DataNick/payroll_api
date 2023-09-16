class PayrollReportSerializer < ActiveModel::Serializer
    attributes :payroll_report, :employee_reports, :employee_id, pay_period
    set_key_transform :camel_lower
  end