class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :current_user

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = User.where(id: session[:user_id]).first
  end

  def authenticate_user!
    redirect_to login_path, alert: "Faça login para continuar" unless current_user
  end

  def authorize_admin!
    redirect_to root_path, alert: "Acesso negado" unless current_user&.admin?
  end
end
