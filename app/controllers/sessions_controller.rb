class SessionsController < ApplicationController
  
  include ApplicationHelper
  
  def new
  end
	
	def create	  		
	  user = User.find_by_login(params[:user])	 if params[:user].present? 	  
	  if user && User.encrypt(params[:pass], user.salt) == user.hashed_password	    	    
	    session[:current_user] = user.id
	    redirect_to '/main/index'
	  else	    
	    flash[:message] = error_message 'Usuário e/ou senha inválidos'
	    render :action => :new
	  end    	  
	end
	
	def destroy
  end	
	
end