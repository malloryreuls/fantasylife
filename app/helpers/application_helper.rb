module ApplicationHelper
  
  def current_user
    @current_user ||= session[:remember_token] && User.find(session[:remember_token])
  end

end
