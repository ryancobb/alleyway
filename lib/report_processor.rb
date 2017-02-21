module ReportProcessor
	class Report
		attr_reader :response

		def initialize(job)
			@response = build_response(job)
		end

		private

		def build_response(job)
			response = []

			get_files(job).each do |file|
				response.push JSON.parse(File.read(file))
			end

			response
		end

		def get_files(job)
			Dir["selenium_tests/reports/#{job.guid}.*.json"]
		end
		
	end
end