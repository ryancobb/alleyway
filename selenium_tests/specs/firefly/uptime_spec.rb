require_relative '../spec_helper'

describe "uptime verification", :type => :feature do
  let(:base_url) { ::Alleyway.get_service_url("firefly") }

  it "go to pinkbike" do
  	visit base_url
    sleep(5)
  end

  it "errors terribly" do
  	visit "#{some_variable}"
  end

  it "fails horribly" do
  	visit "http://www.mx.com"
  	expect(page).to have_link("NOPE")
  end
end