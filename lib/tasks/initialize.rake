namespace :db do  
  desc "Criacao de banco, tabelas e dados basicos para utilizacao do sistema de ouvidoria"
  task :init do   
    puts ""
    puts ""    
    puts "*****************************************"
    puts " "
    puts "Sistema de Ouvidoria "
    puts "   versao 0.5.1"
    puts "   release de 26/05/2009"
    puts "   rails versao 2.3.2"
    puts "   desenvolvido por Marcia Almeida, com base nas necessidades da Camara Municipal de Porto Alegre"
    puts "   contato: marcia.almeida@camarapoa.rs.gov.br"
    puts " "
    puts "*****************************************"
    puts ""
    puts ""
    puts "Iniciando setup do sistema..."
    puts " "    
    puts "  -  apagando banco antigo, caso exista ..."
  	Rake::Task['db:drop'].invoke
  	puts "  -  criando novo banco ..."
  	Rake::Task['db:create'].invoke  	
  	puts "  -  criando tabelas..."
  	puts ""
  	#Rake::Task['db:schema:load'].invoke
  	Rake::Task['db:migrate'].invoke
  	puts ""
  	puts "  - setup de banco executado com sucesso"
  	puts ""
  	puts ""
  	puts "Digite agora o e-mail do adminisrador do sistema."
  	
    email_input = STDIN.gets.chomp    
	  user = User.new(:name => 'Admin User', :login => 'admin', :password => 'ouvidoria', :password_confirmation => 'ouvidoria', :email => email_input)
    user.save!
    puts " "
    puts "Atencao!"
    puts "Foi cadastrado usuario para acesso ao sistema"
    puts "Usuario: admin"
    puts "Senha: ouvidoria"
    puts "  "
    puts "  "
    puts 'Setup concluido com sucesso.'    
    
  end
end