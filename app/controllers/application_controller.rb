class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sing_up,keys:[:nickname, :avatar, :introduction, :first_name, :first_name_reading, :last_name, :last_name_reading, :birthday, :earnings, :points, address_attributes:[:phone_number, :postal_code, :city,:house_number,  :building_name]])
  end
end
