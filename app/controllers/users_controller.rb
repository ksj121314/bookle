class UsersController < ApplicationController
  def signup
  end

  def signup_complete
    user = User.new
    user.username = params[:username]
    if params[:password] == params[:retype_password]
      user.password = params[:password]
      user.money = 20000 #첫 회원가입 초기자금 2만원
      if user.save
        flash[:alert] = "성공적으로 가입되었습니다."
        redirect_to "/users/login"
      else
        flash[:alert] = user.errors.values.flatten.join(' ')
        redirect_to :back
      end
    else
      flash[:alert] = "비밀번호가 맞지 않습니다."
      redirect_to :back
    end
  end

  def login
  end

  def login_complete
    user = User.where(username: params[:username])[0]
    if user.nil?
      flash[:alert] = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
      redirect_to :back
    elsif user.password != params[:password]
      flash[:alert] = "아이디 또는 비밀번호를 잘못 입력하셨습니다."
      redirect_to :back
    else
      session[:user_id] = user.id
      session[:username] = user.username
      session[:money] = user.money
      flash[:alert] = "성공적으로 로그인하였습니다."
      redirect_to "/"
    end
  end

  def logout_complete
    reset_session
    flash[:alert] = "성공적으로 로그아웃하였습니다."
    redirect_to "/"
  end

  def purchase_list
    @purchaselists = PurchaseList.all
  end
end
