class ApplicationController < ActionController::Base
    before_action :turbo_frame_request_variant
    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
  
    protected
  
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password)}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :email, :password, :current_password)}
    end

    private
  
    def turbo_frame_request_variant
      request.variant = :turbo_frame if turbo_frame_request?
    end
end
