class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user! , only: [ :new, :edit ]

  def new
    @review = Review.new
  end

  def create
		@review = @book.reviews.build(review_params)
		@review.user_id = current_user.id
    @review.book_id = @book.id


		if @review.save
      flash[ notice ] = 'Review has been created.'
			redirect_to @book
		else
			render 'new'
		end
	end

  def edit
	end

	def update
		if @review.update(review_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

  def destroy
		@review.destroy
		redirect_to book_path(@book)
	end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
		@review = Review.find(params[:id])
	end

end
