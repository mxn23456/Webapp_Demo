class ApplicationController < ActionController::Base

  #skip protect_from_forgery if requesting with json
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }

  #verify user authenticity
  before_action :authenticate_user! 

end
