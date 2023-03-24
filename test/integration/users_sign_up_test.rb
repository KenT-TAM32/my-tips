require "test_helper"

class UsersSignUpTest < ActionDispatch::IntegrationTest

  test "invalid signup infomation" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { 
      user: { name: "",
      email: "user@david",
      password: "foo",
      password_confirmation: "bar" }
      }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end
end
