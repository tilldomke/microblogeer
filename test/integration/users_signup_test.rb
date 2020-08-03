require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup info" do
    get signup_path #get the signup page. not necessary put makes sense

    #post mock form data 
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: { 
        name: "",
        email: "user@derp",
        password: "lel",
        password_confirmation: "lul"
        }
      }
    end
    assert_template 'users/new'
    #check if errors render
    assert_select 'div#error_explanation'
  end

  test "valid signup" do
   assert_difference "User.count" do
     post users_path, params: {
       user: {
        name: "Example Boy",
        email: "user@derp.com",
        password: "password",
        password_confirmation: "password"
       }
     }
   end
  follow_redirect! #to make the redirect defined in the controller work in test
  assert_template "users/show"
  assert_not flash.empty?
  end

end
