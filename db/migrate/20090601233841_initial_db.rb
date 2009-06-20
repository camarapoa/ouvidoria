class InitialDb < ActiveRecord::Migration
  def self.up
    
    create_table :users do |t|
	    t.string		:name		
	    t.string		:login
	    t.string		:hashed_password
	    t.string		:email
	    t.string		:salt
	    t.timestamps	    
	    t.integer   :created_by	    
	    t.integer   :updated_by
    end  
  
    create_table :destinos do |t|
      t.string    :nome
      t.string    :emails
      t.string    :status     
      t.string    :tipo 
      t.timestamps    
      t.integer   :created_by      
      t.integer   :updated_by
    end  
  
    create_table  :demandas do |t|
      t.string  :demandante
      t.string	:descricao
      t.string  :email
      t.string  :endereco
      t.string  :telefone
      t.string  :celular
      t.string  :status
      t.string	:destino_id
      t.timestamps       
      t.integer :created_by      
      t.integer :updated_by
    end
    
    create_table  :historico do |t|    
      t.date    :data
      t.string  :descricao                
      t.timestamps       
      t.integer :created_by
      t.integer :updated_by
    end
    
  end

  def self.down
    
  end
end
