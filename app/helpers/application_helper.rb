module ApplicationHelper

	def current_user
		#not optimized:
		#User.find(session[:user_id]) if session[:user_id]
		#optimized:
		  @current_user ||= User.find(session[:user_id]) if session[:user_id]

	end
end
