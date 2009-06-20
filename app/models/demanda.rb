class Demanda < ActiveRecord::Base
	
	belongs_to :destino
	
	validates_presence_of	:demandante, :descricao
	validates_format_of :email,
	  :with => /\A(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22(?:[^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22)(?:\x2e(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22(?:[^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22))*\x40(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b(?:[^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d)(?:\x2e(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b(?:[^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d))*\z/,
		:allow_blank => true
	
	before_create Proc.new{|record| record.status = 'pendente'}	
	
	named_scope	:limit, lambda { |num| { :limit => num } }
	named_scope	:last_week, :conditions => ["created_at > ?", 1.week.ago], :order => 'created_at desc'
	named_scope	:nova, :conditions => {:status => 'nova'}
	named_scope	:em_atendimento, :conditions => {:status => 'em_atendimento'}

	
	STATUS = [['Em Atendimento',:em_atendimento],
	  ['Finalizada Sem Solução',:finalizada_sem_solucao],		
		['Nova',:nova],		
		['Resolvida',:resolvida]]
		
	def validate
		#ao menos uma forma de contato de ve ser informada
		errors.add(nil, 'Indique ao menos uma forma de contato') if !contato_informado?
	end
		
	def self.search(params)
		conditions =  []
		conditions << "demandante like '%#{params[:demandante]}%'"
		conditions << "id like '%#{params[:numero]}%'"
		conditions << "status like '%#{params[:status]}%'"		
		Demanda.all(:conditions => conditions.join(' AND '), :order => :created_at)				
	end
	
	
	def contato_informado?
		return true if self.endereco.present? || self.email.present? || self.telefone.present? || self.celular.present?
		return false 
	end
		
		
end