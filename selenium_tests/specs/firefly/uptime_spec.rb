require_relative '../spec_helper'

describe "uptime verification", :type => :feature do

  it "go to pinkbike" do
  	visit 'http://www.pinkbike.com'
  end

  it "errors terribly" do
  	visit "#{some_variable}"
  end

  it "fails horribly" do
  	visit "http://www.mx.com"
  	expect(page).to have_link("NOPE")
  end
end