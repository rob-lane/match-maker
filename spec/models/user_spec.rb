require 'spec_helper'

describe User do
  
  before(:each) do
    @user_attribs  = { screen_name: "tester",  email: "test@tester", "Password" => "m434edr02a", 
        "Password Confirmation" => "m434edr02a" }
  end
  
  it "should create a new instance with valid attributes" do
    User.create!(@user_attribs);  
  end
  
  it "should require a screen_name" do
    no_screen_name_user = User.new @user_attribs.merge(screen_name:'')
    no_screen_name_user.should_not be_valid
  end
  
  it "should require a valid enail" do
    no_email_user = User.new @user_attribs.merge(email:'')
    no_email_user.should_not be_valid
  end
  
  it "should reject duplicate emali address" do
    user1 = User.create!(@user_attribs)
    user2 = User.new @user_attribs
    user2.should_not be_valid
  end
  
  describe "password validation" do
    
    before(:each) do
      @user = User.create!(@user_attribs)
    end
    
    it "should have an encrypted password" do
      @user.should respond_to(:password)
      @user.password.should_not be_blank
    end
    
    it "should have password compare function" do
      @user.should respond_to(:has_password?)
    end
    
    it "should have a matching encrypted password" do
      @user.has_password?(@user_attribs["Password"]).should be_true  
    end
  end
    
end