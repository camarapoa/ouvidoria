
class Destino < ActiveRecord::Base
  
  validates_presence_of :nome,  :status, :tipo	  
 # validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
  TIPOS = [:Funcionario, :Parlamentar, :Setor ]
  
  named_scope :search, lambda { |text| {:conditions => ["nome LIKE ?", "%#{text}%"]} }
  
  def validate
  	#validação de emails
  	errors.add(:emails,'Digite ao menos um email para o destino') if !emails.present?  	
  	errors.add(nil,'Há e-mails inválidos informados') if !validates_array_emails(emails)
  	
	end  
  
  def validates_email(email)
  	return email =~ /\A(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22(?:[^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22)(?:\x2e(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22(?:[^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22))*\x40(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b(?:[^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d)(?:\x2e(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b(?:[^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d))*\z/
	end
	
	def validates_array_emails(emails)
		#pressupõe que e-mails estejam separados por ponto-e-vírgula
		result = true
		array_emails = emails.split(';')
		for email in array_emails
			if !validates_email(email).present?
				result = false 
				break
			end			
		end
		return result		
	end
	
	
  
end