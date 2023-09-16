class TimesheetEntry < ApplicationRecord
  belongs_to :employee
  belongs_to :job_group

  validates :workday, :hours, :report_id, presence: true 
  
end
