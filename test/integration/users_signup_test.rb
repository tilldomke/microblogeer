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

end
