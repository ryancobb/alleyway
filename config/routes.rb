Rails.application.routes.draw do
  get 'jobs/:job_guid/status' => "jobs#status"

  post 'selenium/run'
  get  'selenium/specs'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
