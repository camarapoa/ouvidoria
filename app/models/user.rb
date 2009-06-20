require 'digest/sha1'

class User < ActiveRecord::Base
	
	attr_protected :id, :salt	
	attr_accessor :password, :password_confirmation
	
	validates_presence_of :name, :login, :email, :password, :password_confirmation, :salt
	validates_length_of :login, :within => 3..40
  validates_length_of :password, :within => 5..40
  validates_uniqueness_of :login, :email
  validates_confirmation_of :password
  validates_format_of :email, :with => /\A(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22(?:[^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22)(?:\x2e(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22(?:[^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22))*\x40(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b(?:[^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d)(?:\x2e(?:[^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b(?:[^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d))*\z/  
  
  def self.authenticate(login, pass)
    user = User.find(:conditions => {:login => login})
  	return nil if !user  		
	  return user if User.encrypt(pass, u.salt)==user.hashed_password
	  nil
  end  

  def password=(pass)
	  @password=pass
	  self.salt = User.random_string(10) if !self.salt?
	  self.hashed_password = User.encrypt(@password, self.salt)
	end	
	
	protected
	
	def self.encrypt(pass, salt)
		Digest::SHA1.hexdigest(pass+salt)
	end
	
	def self.random_string(len)
	  #generat a random password consisting of strings and digits
	  chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
	  newpass = ""
	  1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
	  return newpass
	end
	
end
	