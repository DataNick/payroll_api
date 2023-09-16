class Employee < ApplicationRecord
    has_many :timesheet_entries
end
