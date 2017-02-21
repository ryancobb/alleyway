class JobsController < ApplicationController
  def status
  	job = find_job

  	render json: job.as_json
  end

  private

  def job_params
  	params.require(:job_guid)
  end

  def find_job
  	Job.find_by(:guid => job_params[:job_guid])
  end
end
