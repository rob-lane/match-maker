module UsersHelper
  def encrypt_password
    return unless self.respond_to?(:password) && self.respond_to?(:salt)
    self.salt = make_salt if new_record?
    self.password = encrypt_value self.password
  end
  
  private
    def encrypt_value(string_value)
      secure_hash "#{self.salt}--#{string_value}"
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{self.password}")
    end
    
    def secure_hash(string_value)
      Digest::SHA2.hexdigest(string_value)
    end
end
