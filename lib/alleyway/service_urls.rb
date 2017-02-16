class Alleyway
	SERVICE_URLS = {
		:firefly => {
			:sand => "https://sand-app.moneydesktop.com/",
			:qa => "https://qa-app.moneydesktop.com/",
			:int =>  "https://sd-int-app.moneydesktop.com/",
			:prod => "https://sd-prod-app.moneydesktop.com/"
		}
	}.freeze

	def self.get_service_url(service)
		SERVICE_URLS[service.downcase.to_sym][ENV['ENVIRONMENT'].downcase.to_sym]
	end
end