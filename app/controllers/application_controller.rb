class ApplicationController < ActionController::Base
  rescue => e
    Rails.logger.error("ERROR Occured: #{e}")
end
