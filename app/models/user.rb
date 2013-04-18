class User < ActiveRecord::Base
  include UsersHelper
  attr_accessible :email, :password, :salt, :screen_name
  
  before_save :encrypt_password  
  
  validates :email, :presence => true, 
        :uniqueness => true, :confirmation => true, 
        :format => {:with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :screen_name, :presence => true, :uniqueness => true
  
  def has_password?(passwordString)
    self.password == encrypt_value(passwordString)
  end
  
  def authenticate(email, password)
    user = user.find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(password)
  end
  
  def authenticate_cookie(id, cookie_salt)
    user = find(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

end
