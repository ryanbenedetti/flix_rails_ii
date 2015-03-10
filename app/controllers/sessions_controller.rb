class SessionsController < ApplicationController

  def new
	
  end

  def create
  	user = User.find_by(email: params[:email])
    
    if User.authenticate(params[:email], params[:password])
    	session[:user_id] = user.id
    	flash[:notice] = "Welcome back, #{user.name}!"
       #Redirect to intended url
       redirect_to(session[:intended_url] || user)
       #Remove intended url from session
       session[:intended_url] = nil
    else
    	flash.now[:alert] = "Invalid email/password combination!"
    	render :new
    end
  end


  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "You're now signed out!"
  end

end
