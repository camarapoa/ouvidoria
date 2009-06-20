class UsersController < ApplicationController

  before_filter :login_required, :only=>['welcome', 'change_password', 'hidden']
  
  include ApplicationHelper
  
  def index
    @menu = "usuarios"
    @users = User.all(:order => :name)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:message] = notice_message 'Usuário cadastrado com sucesso'
      redirect_to users_path
    else
      render :action => :new
    end
  end
  
  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:message] = notice_message 'Usuário removido com sucesso'
    else
      flash[:message] = error_message 'Problemas na exclusão de usuário'      
    end
    redirect_to users_path
  end
    
  

  def signup
    @user = User.new(@params[:user])
    if request.post?  
      if @user.save
        session[:user] = User.authenticate(@user.login, @user.password)
        flash[:message] = "Signup successful"
        redirect_to :action => "welcome"          
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
    if request.post?
      if session[:user] = User.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Login successful"
        redirect_to_stored
      else
        flash[:warning] = "Login unsuccessful"
      end
    end
  end

  def logout
    session[:user] = nil
    flash[:message] = 'Logged out'
    redirect_to :action => 'login'
  end

  def forgot_password
    if request.post?
      u= User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        flash[:message]  = "A new password has been sent by email."
        redirect_to :action=>'login'
      else
        flash[:warning]  = "Couldn't send password"
      end
    end
  end

  def change_password
    @user=session[:user]
    if request.post?
      @user.update_attributes(:password=>params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
      if @user.save
        flash[:message]="Password Changed"
      end
    end
  end

  def welcome
  end
  def hidden
  end
  
end
