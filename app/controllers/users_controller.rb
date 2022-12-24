class UsersController < ApplicationController
  before_action :authenticate_user!

  before_action :ensure_correct_user, only:[:edit]
  def new
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book)
    else
      render :index
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
    @user=User.find(params[:id])
    @user.update(user_params)
    render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user.id)
    end
end

end
