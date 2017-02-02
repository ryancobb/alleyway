module ReportProcessor
	class Report
		attr_reader :file
		attr_accessor :response

		def initialize(file)
			@file = file
			@response = []
		end

		def process
			puts "Processing file!!"
			doc = File.open(file){ |f| Nokogiri::XML(f)}

			parse_document(doc)
		end

		private

		def parse_document(doc)
			doc.xpath("//testsuite").each do |doc_suite|
				build_test_suite_run(doc_suite)
			end
		end

		def build_test_suite_run(doc_suite)
			doc_suite_name = doc_suite.at_xpath("@name").value
			doc_suite_timestamp = doc_suite.at_xpath("@timestamp").value.to_time
			system_out = doc_suite.at_xpath("system-out").inner_html
			env = system_out.match(/Environment: (.*),/)[1]
			browser = system_out.match(/Browser: (.*)/)[1]



			test_suite_run = {
				:name       => doc_suite_name,
				:started_at => doc_suite_timestamp,
				:system_out => system_out,
				:env        => env,
				:browser    => browser,
				:test_cases => build_test_case_runs(doc_suite)
			}

			response.push(test_suite_run)
		end

		def build_test_case_runs(doc_suite)
			test_case_runs = []

			doc_suite.xpath("testcase").each do |doc_testcase|
				doc_testcase_name = doc_testcase.at_xpath("@name").value
				doc_testcase_time = doc_testcase.at_xpath("@time").value

				test_case_runs.push({
					:name     => doc_testcase_name,
					:run_time => doc_testcase_time,
					:errors   => build_errors(doc_testcase)
				})
			end

			test_case_runs
		end

		def build_errors(doc_testcase)
			errors = []
			doc_errors = doc_testcase.xpath("error", "failure")

			unless doc_errors.blank?
				doc_errors.each do |error|
					errors.push({
						:type => error.at_xpath("@type").value,
						:message => error.at_xpath("@message").value
					})
				end
			end

			errors
		end
	end
end