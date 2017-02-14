class AddResponseToJob < ActiveRecord::Migration[5.0]
  def change
  	add_column :jobs, :response, :string
  end
end
