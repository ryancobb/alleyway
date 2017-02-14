class JobsController < ApplicationController
  def status
  	job = find_job

  	render json: job.as_json
  end

  private

  def find_job
  	Job.find_by(:guid => params[:job_guid])
  end
end
