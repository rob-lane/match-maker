class User < ActiveRecord::Base
  attr_accessible :email, :password, :salt, :screen_name
end
