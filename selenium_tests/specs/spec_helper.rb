require 'capybara/rspec'
require 'alleyway'

Capybara.register_driver :selenium do |app|
	Capybara::Selenium::Driver.new(app, 
		:browser => :remote,
		:desired_capabilities => BROWSER.to_sym,
		:url => "http://localhost:4444/wd/hub"
		)
end

Capybara.default_driver = :selenium

RSpec.configure do |config|
	config.color = true
	config.tty = true

	config.failure_exit_code = 0
end