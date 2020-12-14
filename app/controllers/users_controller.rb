class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     user = User.find(params[:id])
    if user.update(user_params)
      flash[:success] = "Complete"
      redirect_to user_path(user.id)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def following
  	@user = User.find(params[:id])
  	@users = @user.following
    render 'show_follow'
  end

  def followers
  	@user = User.find(params[:id])
  	@users = @user.followers
    render 'show_follower'
  end

  def hide
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "またのご利用をお待ちしております。"
    redirect_to root_path
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :email)
  end
end
