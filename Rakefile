# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'rspec/core/rake_task'

namespace :selenium do
	root_dir = 'selenium_tests/specs'
	features = Dir["#{root_dir}/*/"]

	features.each do |feature|
		feature = feature.match(/selenium_tests\/specs\/(\w*)\/\z/)[1]

		# Create individual rake tasks, for example: selenium:firefly:uptime
		namespace :"#{feature}" do
			tests = Dir["#{root_dir}/#{feature}/*_spec.rb"]

			tests.each do |test|
				file = File.read(test)
				describe_text = file.match(/describe "(.*)",/)[1]
				test_name = test.match(/selenium_tests\/specs\/#{feature}\/(\w*)_spec.rb\z/)[1]

				desc "#{feature} - #{describe_text}"
				RSpec::Core::RakeTask.new(:"#{test_name}", :job_guid) do |t, task_args|
					t.pattern = "#{root_dir}/#{feature}/#{test_name}_spec.rb"
					t.rspec_opts ="--format CustomFormatter > selenium_tests/reports/#{task_args[:job_guid]}.json"
				end
			end
		end
	end
end

Rails.application.load_tasks