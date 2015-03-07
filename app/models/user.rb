class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true,
  			  		format: /\A\S+@\S+\z/,
  					uniqueness: { case_sensitive: false}

  validates :username, presence: true,
  			  		format: /\A[A-Z0-9]+\z/i,
  					uniqueness: { case_sensitive: false}




#Add gravatar service MD5 hash to app
#See this article for more: http://en.gravatar.com/site/implement/hash/

def gravatar_id
  Digest::MD5::hexdigest(email.downcase)
end

def self.authenticate(email, password) 
 user = User.find_by(email: email)
 user && user.authenticate(password)
end

end
