class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = current_user.books.build
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def create
    @book = current_user.books.build(book_params)
    @book.category_id = params[:category_id]
    if @book.save
      flash[ notice ] = 'Book has been created.'
      redirect_to books_path
    else
      flash.now[ alert ] = 'Book has not been created.'
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[ notice ] = 'Book has been updated.'
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    flash[ notice ] = 'Book has been deleted.'
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :description, :author)
  end
end
