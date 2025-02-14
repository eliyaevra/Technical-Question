class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @borrowings = current_user.borrowings.where(returned_at: nil)
  end
end
