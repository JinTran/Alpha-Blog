class UsersController < ApplicationController

  before_action :set_user, only: [:edit,:update,:delete]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @user = User.find(params[:id])
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    @user_books = @user.books.paginate(page: params[:page], per_page: 5)

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id   #set up login after signup
      flash[:success] = "Welcome to Alpha-Blog"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:danger] = "User has been deleted"
      redirect_to users_path
    end
  end


  private
  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:username, :email, :password,:admin)
  end

  def require_same_user
    if  current_user != @user  and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own account"
      redirect_to root_path
    end
  end
  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admin users can delete this account"
      redirect_to root_path
    end
  end
end
