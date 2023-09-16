class AddEmployeeCompanyIdToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :employee_company_id, :integer
  end
end
