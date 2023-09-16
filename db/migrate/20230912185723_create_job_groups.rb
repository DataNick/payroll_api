class CreateJobGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :job_groups do |t|
      t.string :group_code
      t.decimal :hourly_wage

      t.timestamps
    end
  end
end
