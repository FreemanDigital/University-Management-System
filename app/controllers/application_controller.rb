class ApplicationController < ActionController::Base
  # stackoverflow.com/questions/45065065/rails-5-redirect-notice-style
  add_flash_types :success, :warning, :danger, :info
end