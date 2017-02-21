class RakeHelper
	def self.get_selenium_specs
		commands = get_commands
		descriptions = get_descriptions
  	commands_descriptions_hash = Hash[commands.zip(descriptions)]

  	sorted_hash = Hash.new {|h, k| h[k] = {}}

  	commands_descriptions_hash.each do |key, val|
  		split_command = key.split(':')

  		feature = split_command[0]
  		filename = split_command[1]

  		sorted_hash[feature][filename] = {
  			:description => val,
  			:command => key
  		}
  	end

  	sorted_hash
	end

	def self.run(job)
	 Thread.new {
	 	begin
			job.update(:status => "running")
			%x[rake #{job.commands}]
			job.update(:status => "building report")
			report = ::ReportProcessor::Report.new(job)
			job.update(:response => report.response, :status => "complete")
			job.send_response
		ensure
			job.cleanup
		end
		}
	end

	def self.get_commands
		%x[rake -T | sed -n '/selenium:/{/grep/!p;}' | awk '{print$2}'].gsub(/selenium:/, "")
			.gsub(/\[job_guid,browser,environment\]/, "").split("\n")
	end

	def self.get_descriptions
		%x[rake -T | sed -n '/selenium:/{/grep/!p;}' | awk '{$1=$2=$3=""; print $0}'].split("\n")
  		.each(&:lstrip!)
	end
end