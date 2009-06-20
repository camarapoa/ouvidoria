class DestinosController < ApplicationController
  
  include ApplicationHelper
  
  def index
    @menu = "destinos"
    @busca = params[:busca]
    @destinos = @busca.blank? ? Destino.all : Destino.search(@busca)  
  end
  
  def new
    @menu = "destinos"
    @destino = Destino.new
  end
  
  def create
    @destino = Destino.new(params[:destino])
    if @destino.save
      flash[:message] = success_message 'Destino cadastrado com sucesso'
      redirect_to destinos_path
    else      
      render :action => :new
    end    
  end
  
  def edit
    @menu = "destinos"
    @destino = Destino.find(params[:id])
  end
  
  def update    
    @destino = Destino.find(params[:id])
    if @destino.update_attributes(params[:destino])
      flash[:message] = success_message 'Destino alterado  com sucesso'
      redirect_to destinos_path
    else
      flash[:message] = error_message 'Problemas ao editar destino'
      render :action => :edit
    end
  end
  
  def destroy
  	@destino = Destino.find(params[:id])
  	begin
	  	if @destino.destroy
	      flash[:message] = warning_message 'Destino excluído'	    
	    else
	      flash[:message] = error_message 'Problemas ao excluir destino'	      
	    end
	    redirect_to destinos_path
 		rescue Exception => e
 			flash[:message] = error_message "Problemas ao excluir destino (#{e})"
 			redirect_to destinos_path
		end 
	end		 	
  
end
