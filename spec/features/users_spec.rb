require 'spec_helper' 

describe "Web user" do
  
  it "navigates to root URL" do
    visit root_path
    response.should redirect_to(new_sessions_path)
  end
  
  describe "registration" do
    
    before(:each) do 
      @fields = {"Screen Name" => "tester", "Email" => "tester@test.com", "Password" => "m434edr02a", 
        "Password Confirmation" => "m434edr02a"}
    end
    
    describe "success" do
      it "should make a new user" do
        -> {
          visit new_user_path
          fields.each_pair do |field, value|
            fill_in field, :with => value
          end
          click_button
          response.should have_selector("div.flash.success", :content => "Welcome")
          response.should redirect_to(root_path)
        }.should change(User, :count)
      end
    end
    
    describe "failure" do
      it "should not make a new user" do
        -> {
          visit new_user_path
          fields.each_key do |field|
            fill_in field, :with => ""
          end
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        }.end should_not change(User, :count)
      end  
    end
  end
  
end
