class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(params_book)
    if @book.save
      flash[ notice ] = 'Book has been created.'
      redirect_to books_path
    else
      flash.now[ alert ] = 'Book has not been created.'
      render 'new'
    end
  end

  private

  def params_book
    params.require(:book).permit(:title, :description, :author)
  end
end
