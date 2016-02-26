class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , only: [ :new, :edit, :destroy ]

  def index
    if params[:category].blank?
      @books = Book.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @books = Book.where(:category_id => @category_id).order("created_at DESC")
    end
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
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end

  end

  def edit

    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update

    @book.category_id = params[:category_id]
    if @book.update(book_params)
      flash[ notice ] = 'Book has been updated.'
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy

    @book.destroy

    flash[ notice ] = 'Book has been deleted.'
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
  end

  def set_book
		@book = Book.find(params[:id])
	end
end
