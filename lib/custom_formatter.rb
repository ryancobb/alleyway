require 'rspec/core/formatters/json_formatter'

class CustomFormatter < RSpec::Core::Formatters::JsonFormatter
	::RSpec::Core::Formatters.register self, *(::RSpec::Core::Formatters::Loader.formatters[::RSpec::Core::Formatters::JsonFormatter]), :example_group_started
	
	def initialize(output)
		super(output)
		@output_hash = {
			:browser => BROWSER,
			:environment => ENVIRONMENT,
		}
	end

	def example_group_started(notification)
		@example_group = notification.group.description
	end

	private

  def format_example(example)
  	file_path = example.metadata[:file_path]

	  {
	    :id => example.id,
	    :feature => format_feature(file_path),
	    :file => format_file(file_path),
	    :description => example.description,
	    :example_group => @example_group,
	    :status => example.execution_result.status.to_s,
	    :file_path => example.metadata[:file_path],
	    :line_number  => example.metadata[:line_number],
	    :run_time => example.execution_result.run_time,
	    :pending_message => example.execution_result.pending_message,
	  }
	end

	def format_feature(file_path)
		file_path.match(/\/(\w*)\/\w*_spec.rb$/)[1]
	end

	def format_file(file_path)
		file_path.match(/\/(\w*)_spec.rb$/)[1]
	end
end