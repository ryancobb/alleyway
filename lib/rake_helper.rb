class RakeHelper
	def self.get_selenium_specs
		commands = %x[rake -T | sed -n '/selenium:/{/grep/!p;}' | awk '{print$2}'].gsub(/selenium:/, "")
			.gsub(/\[job_guid\]/, "").split("\n")

  	descriptions = %x[rake -T | sed -n '/selenium:/{/grep/!p;}' | awk '{$1=$2=$3=""; print $0}'].split("\n")
  		.each(&:lstrip!)

  	Hash[commands.zip(descriptions)]
	end

	def self.run(job)
		Thread.new() {
			job.update(:status => "running")
			%x[BROWSER=#{job.browser} ENVIRONMENT=#{job.environment} rake #{job.commands}]
			job.update(:status => "building report")
			report = ::ReportProcessor::Report.new(job)
			job.update(:response => report.response, :status => "complete")
		}
	end
end