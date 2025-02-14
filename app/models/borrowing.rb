class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validate :book_not_already_borrowed

  before_create :set_due_date

  private

  def book_not_already_borrowed
    if book.borrowings.where(returned_at: nil).exists?
      errors.add(:book, "is already borrowed")
    end
  end

  def set_due_date
    self.due_date = 2.weeks.from_now
  end
  def return_book
  self.update(returned_at: Time.current)
end
end

