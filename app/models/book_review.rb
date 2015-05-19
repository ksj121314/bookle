class BookReview < ActiveRecord::Base

  belongs_to  :user
  belongs_to  :book
  has_many  :book_review_comments
  validates :title, :presence => { :message => "제목을 반드시 입력하셔야 합니다." }
end
