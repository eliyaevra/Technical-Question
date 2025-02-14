class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:borrow]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    @book = Book.find(params[:id])
    if @book.borrowings.where(returned_at: nil).exists?
      flash[:alert] = "This book is already borrowed."
    else
      current_user.borrowings.create(book: @book)
      flash[:notice] = "You have borrowed the book!"
    end
    redirect_to books_path
  end
end
