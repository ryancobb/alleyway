class Job < ApplicationRecord

	def self.build_commands(commands, job_guid, browser, environment)
		built_commands = commands.each_with_index.map do |command, index|
			"selenium:#{command}[#{job_guid}.#{index},#{browser},#{environment}]"
		end
		built_commands.join(" ")
	end

	def cleanup
		files = Dir.glob("#{APP_CONFIG["reports_path"]}/#{guid}.*.{rb,json}")
		files.each { |file| File.delete(file) }
	end

	def send_response
		::HTTParty.post("#{APP_CONFIG["frontage_url"]}/jobs", 
			:body => { :job_guid => guid, :results => response }.to_json,
			:headers => { 'Content-Type' => 'application/json' })
	end

end
