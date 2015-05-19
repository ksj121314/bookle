class BooksController < ApplicationController
  before_action :login_check
  skip_before_action  :login_check, :only => [:posts, :posts_category, :show] #해당 작업 3가지 빼고는 전부 로그인이 필요

  def posts
   @books = Book.all
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
    post = Book.find(params[:id])
    user = User.where(id: session[:user_id])[0]
    purchaselist = PurchaseList.new
    if post.price <= session[:money]
      user.money = user.money - post.price
      if user.save
        session[:money] = user.money
        purchaselist.user_id = user.id
        purchaselist.book_id = post.id
        purchaselist.save
        flash[:alert] = "구매 완료하였습니다."
        redirect_to "/"
      else
        flash[:alert] = post.errors.values.flatten.join(' ')
        redirect_to :back
      end

    else
      flash[:alert] = "돈이 모잘랍니다."
      redirect_to :back
    end
  end

  def purchase_list
    # @books = Book.purchaselist.where(id: session[:user_id])[0]
    #@user = User.where(id: session[:user_id])[0]
    #@list = @user.purchase_lists.(params.require(:purchase_list).permit(:book)
    #redirect_to 
    end
end
