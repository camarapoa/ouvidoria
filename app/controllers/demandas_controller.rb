class DemandasController < ApplicationController
  
	include ApplicationHelper
  
  def index
    @menu = "demandas"        
    @demandas_ultima_semana = @demandas = Demanda.last_week
    if params[:status]    
    	@busca = 'busca'
    	@demandas = Demanda.search(params)
    elsif !params[:filtro]
    	@demandas = []
  	elsif params[:filtro] == 'novas'
  		@demandas = Demanda.novas 
  		@filtro = 'Demandas Novas'
  	elsif params[:filtro] == 'em_atendimento'
  		@demandas = Demanda.em_atendimento   	
  		@filtro = 'Demandas em Atendimento'
  	end     
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
  
  def show
  	@demanda = Demanda.find(params[:id])
	end
  
  def destroy
  end  
  
end