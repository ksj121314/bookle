class Book < ActiveRecord::Base
  belongs_to  :user
  has_many  :purchase_lists
  has_many  :book_review
  has_many  :carts
  validates :category, :inclusion => { :in => ["문학","역사","사회과학","교육","취미"], :message => "문학, 역사, 사회과학, 교육, 취미 중 하나를 선택하셔야 합니다." }
  validates :title, :presence => { :message => "제목을 반드시 입력하셔야 합니다." }
  validates :price, :presence => { :message => "가격을 반드시 입력하셔야 합니다." }
  validates :publicdate, :presence => { :message => "발행일자를 반드시 입력하셔야 합니다." }
  validates :out, :inclusion => { :in => ["품절","판매중"], :message => "품절, 판매중 중 하나를 선택하셔야 합니다." }

  before_destroy :ensure_not_referenced_by_any_cart

  private
    def ensure_not_referenced_by_any_cart
      if cart.empty?
        return true
      else
        errors.add(:base, 'Carts present')
        return false
      end
    end
end
