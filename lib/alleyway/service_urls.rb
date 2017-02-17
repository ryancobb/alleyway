class Alleyway
	SERVICE_URLS = {
		:firefly => {
			:sand => "https://proxy-sa-sand-batcave.moneydesktop.com/",
			:qa => "https://proxy-po-qa-batcave.moneydesktop.com/",
			:int => "https://proxy-sd-int-batcave.moneydesktop.com/",
			:prod => "https://proxy-sd-prod-batcave.moneydesktop.com/"
		}
	}.freeze

	def self.get_service_url(service)
		SERVICE_URLS[service.downcase.to_sym][ENVIRONMENT.downcase.to_sym]
	end
	
end