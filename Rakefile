# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'

ENV["CI_REPORTS"] = "selenium_tests/reports/"

namespace :selenium do
	root_dir = 'selenium_tests/specs'
	features = Dir["#{root_dir}/*/"]

	features.each do |feature|
		feature = feature.match(/selenium_tests\/specs\/(\w*)\/\z/)[1]

		# Create top level feature rake tasks to run all children, for example :selenium:firefly
		RSpec::Core::RakeTask.new(:"#{feature}") do |t|
			t.pattern = "#{root_dir}/#{feature}/*_spec.rb"
		end

		task :"#{feature}" => 'ci:setup:rspec'

		# Create individual rake tasks, for example: selenium:firefly:uptime
		namespace :"#{feature}" do
			tests = Dir["#{root_dir}/#{feature}/*_spec.rb"]

			tests.each do |test|
				test = test.match(/selenium_tests\/specs\/#{feature}\/(\w*)_spec.rb\z/)[1]
				RSpec::Core::RakeTask.new(:"#{test}") do |t|
					t.pattern = "#{root_dir}/#{feature}/#{test}_spec.rb"
				end

				task "#{test}" => 'ci:setup:rspec'
			end
		end
	end
end

Rails.application.load_tasks