class SeleniumController < ApplicationController
	before_action :valid_specs?, :only => :run

  def run
  	commands = Job.build_commands(selenium_params[:spec], selenium_params[:job_guid], selenium_params[:browser], selenium_params[:environment])
  
  	job = Job.create(:guid => selenium_params[:job_guid], :status => "initiated", :commands => commands, 
      :environment => selenium_params[:environment], :browser => selenium_params[:browser])

  	::RakeHelper.run(job)

		render json: {
			:guid => job.guid,
			:status => job.status,
		}
  end

  def specs
  	render json: ::RakeHelper.get_selenium_specs
  end

  private

  def selenium_params
    params.require(:selenium).permit(:environment, :browser, :job_guid, :spec => [])
  end

  def valid_specs?
  	requested_specs = selenium_params[:spec]
  	render json: {"error":"specs need to be passed in as an array"}, status: 400 and return unless requested_specs.respond_to?(:to_a)

  	requested_specs.each do |spec|
  		render json: {"error":"#{spec} is not a valid spec"}, status: 400 and return unless ::RakeHelper.get_commands.any? { |valid_spec| valid_spec == spec }
  	end
  end
end
