class BookReviewsController < ApplicationController
  before_action :login_check
  skip_before_action  :login_check, :only => [:posts, :show]

  def posts
   @book_reviews = BookReview.all
  end

  def show
   @book_review = BookReview.find(params[:id])
   @comment_writer = User.where(id: session[:user_id])[0]
  end

  def write
   @book_number = params[:id]
  end

  def write_complete
    post = BookReview.new
    post.user_id = session[:user_id]
    post.title = params[:post_title]
    post.content = params[:post_content]
    post.book_id = params[:post_id]
    #post.user_id = 
    if post.save
      flash[:alert] = "저장되었습니다."
      redirect_to "/book_reviews/show/#{post.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def edit
    @post = BookReview.find(params[:id])
    if @post.user_id != session[:user_id] && session[:user_id] != 1
      flash[:alert] = "수정 권한이 없습니다."
      redirect_to :back
    end
  end

  def edit_complete
    post = BookReview.find(params[:id])
    post.title = params[:post_title]
    post.content = params[:post_content]
    if post.save
      flash[:alert] = "수정되었습니다."
      redirect_to "/book_reviews/show/#{post.id}"
    else
      flash[:alert] = post.errors.values.flatten.join(' ')
      redirect_to :back
    end
  end

  def delete_complete
    post = BookReview.find(params[:id])
    if post.user_id == session[:user_id] || session[:user_id] == 1
      post.destroy
      flash[:alert] = "삭제되었습니다."
      redirect_to "/"
    else
      flash[:alert] = "삭제 권한이 없습니다."
      redirect_to :back
    end
  end

  def write_comment_complete
    comment = BookReviewComment.new
    comment.user_id = session[:user_id]
    comment.book_review_id = params[:post_id]
    comment.content = params[:comment_content]
    comment.save

    flash[:alert] = "새 댓글을 달았습니다."
    redirect_to "/book_reviews/show/#{comment.book_review_id}"
  end
  
  def delete_comment_complete
    comment = BookReviewComment.find(params[:id])
    if comment.user_id == session[:user_id] || session[:user_id] == 1
      comment.destroy
      flash[:alert] = "댓글이 삭제되었습니다."
      redirect_to "/book_reviews/show/#{comment.book_review_id}"
    else
      flash[:alert] = "해당 댓글의 삭제 권한이 없습니다."
      redirect_to :back
    end
  end
end
