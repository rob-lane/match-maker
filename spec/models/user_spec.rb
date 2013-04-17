require 'spec_helper'

describe User do
  
  before(:each) do
    @user_attribs  = { screen_name: "tester",  email: "test@tester" }
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
    
end