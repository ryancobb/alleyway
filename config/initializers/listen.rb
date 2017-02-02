require 'report_processor'

listener = Listen.to('selenium_tests/reports') do |modified, added, removed|
	unless added.blank?
		added.each do |file|
			relative_path = file[/selenium_tests\/reports\/.*\.xml/]
			report = ::ReportProcessor::Report.new(relative_path)
			
			report.process
			puts report.response
		end
	end
end
listener.start