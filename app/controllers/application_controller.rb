class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def verify_user_is_a?(name)
    deny_user unless current_user.send("#{name.to_s}?")
  end

  def deny_user
    flash[:error] = 'You do not have sufficient privileges to view this page'
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :profile_type, :email])
  end
end
