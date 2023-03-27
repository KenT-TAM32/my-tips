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

  test "valid signup infomation" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {name: "example User",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"} }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_not flash.empty?
  end
end
