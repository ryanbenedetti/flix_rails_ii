class UsersController < ApplicationController

before_action :require_signin, except: [:new, :create]
before_action :require_correct_user, only: [:edit, :update, :destroy]
before_action :require_admin, only: [:destroy]

# Not on before_aton callbacks: The order in which you declare before_action methods is crucial. 
# Before an action is run, the before_action methods are executed in turn starting at the top and working down. 
# If at any point along the way one of the before_action methods causes a redirect (or returns false), then execution terminates.
# So by putting the require_correct_user check after the require_signin check, we're assured that the user is signed in before checking that they're the correct user.

def index
	@users = User.all
end


def show
  @user = User.find(params[:id])
  #wire up users to be accessible on view page
  @reviews = @user.reviews
  @favorite_movies = @user.favorite_movies
end

def new
  @user = User.new
end

def create
  	@user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new
    end
end

def edit	

end

def update
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
end


def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_url, alert: "Account successfully deleted!"
end

private

def require_correct_user
    # Find the user being accessed ...
    @user = User.find(params[:id])

    # ... and compare it to the currently signed-in user (the result of calling the current_user method).
    #If the user being accessed is not the signed-in user, then deny access by redirecting to the application home page.
      redirect_to root_url unless current_user?(@user)
end


def user_params
	params.require(:user).
	permit(:name, :username, :email, :password, :password_confirmation)
end



end
