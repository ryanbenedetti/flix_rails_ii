class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private	

  def require_signin
      # Keep track of where user was
      session[:intended_url] = request.url

    unless current_user
      redirect_to new_session_url, alert: "Please sign in first!"
    end	
  end


	def current_user
		#not optimized:
		#User.find(session[:user_id]) if session[:user_id]
		#optimized:
		  @current_user ||= User.find(session[:user_id]) if session[:user_id]

	end

    #helper_methods are available to controllers and views
	helper_method :current_user

    def current_user?(user)
      current_user == user
    end

    #helper_methods are available to controllers and views
  helper_method :current_user?



  def require_admin

    unless current_user_admin?
    redirect_to root_url, alert: "Unauthorized access!" 
    end
    
  end


  def current_user_admin?
    current_user && current_user.admin?
  end

   helper_method :current_user_admin?


end
