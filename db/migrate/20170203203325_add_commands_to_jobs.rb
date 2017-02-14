class AddCommandsToJobs < ActiveRecord::Migration[5.0]
  def change
  	add_column :jobs, :commands, :string
  end
end
