class BooksController < ApplicationController


  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  before_action :set_book, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @books = Book.paginate(page: params[:page],per_page: 5)
  end

  def show

  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:success] = 'Book was successfully created'
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    if @book.update(book_params)
      flash[:success] = 'Book was successfully created'
      redirect_to @book
    end
  end

  def destroy
    @book.destroy
    flash[:danger] = "Book was successfully deleted"

    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end


  def book_params
    params.require(:book).permit(:name, :publisher,:price,:description,:image)
  end

  def require_same_user
    if current_user != @book.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end
end

