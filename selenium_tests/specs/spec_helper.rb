require 'capybara/rspec'

Capybara.register_driver :selenium_chrome do |app|
	Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_driver = :selenium_chrome

RSpec.configure do |config|
	config.color = true
	config.tty = true

	config.failure_exit_code = 0

	config.after(:suite) do
		# puts "Environment: QA, Browser: Chrome"
	end
end

