class AddBrowserAndEnvToJobs < ActiveRecord::Migration[5.0]
  def change
  	add_column :jobs, :browser, :string
  	add_column :jobs, :environment, :string
  end
end
