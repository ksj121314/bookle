class CartsController < ApplicationController
  def create
    @user = User.where(id: session[:user_id])[0]
    @cart = @user.carts.create(params.require(:cart).permit(:book_id))
    redirect_to book_path(@book)
  end
end
