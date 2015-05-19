class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #  protect_from_forgery with: :exception
  #
  def login_check
    @current_user = nil
    if !session[:user_id].nil? #만약 현재 값이 존재하는 경우
      @current_user = User.find(session[:user_id]) #아이디를 찾아 대입
    else
      redirect_to "/users/login" #그렇지 않을 경우 로그인 페이지로 이동
    end
  end
end
