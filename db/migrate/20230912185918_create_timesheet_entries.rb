class CreateTimesheetEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :timesheet_entries do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :job_group, null: false, foreign_key: true
      t.date :workday
      t.integer :hours
      t.integer :report_id

      t.timestamps
    end
  end
end
