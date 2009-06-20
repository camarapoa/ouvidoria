class DemandasController < ApplicationController
  
	include ApplicationHelper
  
  def index
    @menu = "demandas"        
    @demandas_ultima_semana = @demandas = Demanda.last_week
    if !params[:filtro]
    	@demandas = []
  	elsif params[:filtro] == 'novas'
  		@demandas = Demanda.novas 
  	elsif params[:filtro] == 'em_atendimento'
  		@demandas = Demanda.em_atendimento 
  	end     
    
=begin    
    @demandas = []
    if params[:status]    
    	@demandas = Demanda.search(params)
    end    
=end    
  end
  
  def new
  	@menu = "demandas"
  	@demanda = Demanda.new
  	@destinos = Destino.all
  end  
  
  def create
    @demanda = Demanda.new(params[:demanda])
    if @demanda.save
      flash[:message] = success_message 'Demanda cadastrada com sucesso'
      redirect_to demandas_path
    else    
    	@destinos = Destino.all  
      render :action => :new
    end    
  end
  
  def edit
  	@menu = "demandas"
  end
  
  def update
  end
  
  def destroy
  end  
  
end