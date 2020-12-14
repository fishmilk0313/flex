class ApplicationController < ActionController::Base
	before_action :set_search
	 before_action :configure_permitted_parameters, if: :devise_controller?

	def set_search
  	  @search = Post.ransack(params[:q])
  	  @search_products = @search.result
	end

	def after_sign_in_path_for(resource)
    root_path
  	end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
