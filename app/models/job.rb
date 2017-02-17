class Job < ApplicationRecord

	def self.build_commands(commands, job_guid, browser, environment)
		built_commands = commands.each_with_index.map do |command, index|
			"selenium:#{command}[#{job_guid}.#{index},#{browser},#{environment}]"
		end
		built_commands.join(" ")
	end

end
