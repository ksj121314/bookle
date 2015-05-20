class BooksController < ApplicationController
  before_action :login_check
  skip_before_action  :login_check, :only => [:main, :posts, :posts_category, :show, :search_list] #해당 작업 3가지 빼고는 전부 로그인이 필요
 
  def main
  end

  def posts
   @books = Book.all
   @user = User.where(id: session[:user_id])[0]
  end

  def posts_category
    case params[:category]
    when "literature"
      @category = "문학"
    when "history"
      @category = "역사"
    when "socialscience"
      @category = "사회과학"
    when "education"
      @category = "교육"
    when "hobby" #else
      @category = "취미"
    end
    @books = Book.where(category: @category)
  end

  def show
    @book = Book.find(params[:id])
    @review_writer = User.where(id: session[:user_id])[0]
  end

  def write
    if session[:user_id] != 1 #관리자는 1번이라고 가정
      flash[:alert] = "관리자 권한이 없습니다."
      redirect_to "/"
    end
  end

  def write_complete
    post = Book.new
    post.user_id = session[:user_id]
    post.category = params[:post_category]
    post.title = params[:post_title]
    post.content = params[:post_content]
    post.price = params[:post_price]
    post.publicdate = params[:post_publicdate]
    post.out = params[:post_out]

    if post.save
      flash[:alert] = "저장되었습니다."
      redirect_to "/books/show/#{post.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != session[:user_id]
      flash[:alert] = "수정 권한이 없습니다."
      redirect_to :back
    end
  end

  def edit_complete
    post = Book.find(params[:id])
    post.category = params[:post_category]
    post.title = params[:post_title]
    post.content = params[:post_content]
    post.price = params[:post_price]
    post.publicdate = params[:post_publicdate]
    post.out = params[:post_out]

    if post.save
      flash[:alert] = "수정되었습니다."
      redirect_to "/books/show/#{post.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def delete_complete
    post = Book.find(params[:id])
    if post.user_id == session[:user_id]
      post.destroy
      flash[:alert] = "삭제되었습니다."
      redirect_to "/"
    else
      flash[:alert] = "삭제 권한이 없습니다."
      redirect_to :back
    end
  end

  def purchase_complete
    user = User.where(id: session[:user_id])[0]
    shoppinglist = ShoppingList.where(user_id: user.id)
    if shoppinglist.size == 0
       flash[:alert] = "장바구니가 비었습니다."
       redirect_to :back
    else

    if session[:money] >= params[:price].to_i
      user.money = user.money - params[:price].to_i
      if user.save
        session[:money] = user.money
        shoppinglist.each do |sl|
          purchaselist = PurchaseList.new
          purchaselist.user_id = user.id
          purchaselist.book_id = sl.book_id
          purchaselist.save
          sl.destroy
        end
          flash[:alert] = "구매 완료하였습니다."
          redirect_to "/books/purchase_list"
        else
          flash[:alert] = post.errors.values.flatten.join(' ')
          redirect_to :back
        end

      else
        flash[:alert] = "돈이 모잘랍니다."
        redirect_to :back
      end
    end
  end

  def purchase_list
     @purchaselist = PurchaseList.where(user_id: session[:user_id])
     @total_price = 0
     @purchaselist.each do |sl|
       @total_price += sl.book.price
     end
  end

  def shopping_list_add
     post = Book.find(params[:id])
     if post.out == "판매중"
       user = User.where(id: session[:user_id])[0]
       cartdata = ShoppingList.new
       cartdata.user_id = user.id
       cartdata.book_id = post.id
       cartdata.save
       flash[:alert] = "담기 완료하였습니다."
       redirect_to "/books/shopping_list"
     else
       flash[:alert] = "품절된 상품입니다."
       redirect_to :back
     end
  end

  def shopping_list
     @shoppinglist = ShoppingList.where(user_id: session[:user_id])
     @total_price = 0
     @shoppinglist.each do |sl|
       @total_price += sl.book.price
     end
  end

  def shopping_delete
     post = ShoppingList.find(params[:id])
     post.destroy
     flash[:alert] = "제외 되었습니다."
     redirect_to "/books/shopping_list"
  end
 
  def search_list
    @books = Book.where(title: params[:search_data])
    @allbooks = Book.all

    @allbooks.each do |b|
      if b.title.include? params[:search_data] #검색한 단어가 포함되어있을 경우
        if  b.title != params[:search_data] #동일한이름은 선언할때 찾았으므로 제외
          @books += Book.where(title: b.title)
        end
      end
    end

  end
end
