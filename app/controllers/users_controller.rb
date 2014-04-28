class UsersController < ApplicationController

  def edit
  	@user = current_user
  end

  def index
  end

  def new
  	@user = User.new
  end

  def show
  end

  def update
  	@user = current_user
  	if @user.update_attributes(user_params)
		redirect_to(@user, :notice => 'User was successfully updated.')
	else
		render :action => 'edit'
	end
  end

  def create 
	@user = User.new(user_params)
    if @user.save
   	  session[:user_id] = @user.id
      # message for confirming that a camp was added
      redirect_to home_path, notice: "This user was added to the system."
    else
      render action: 'new'
    end
  end

  private
  def user_params
	params.require(:user).permit(:username, :role, :password, :password_confirmation, :active)
  end

end
