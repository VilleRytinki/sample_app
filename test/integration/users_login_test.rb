require "test_helper"

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
  end
end

class InvalidUserCredentialsTest < UsersLogin
  test "login path" do
    get login_path
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
  end

  test "login with invalid in both fields" do
    post login_path, params: { session: { email: "", password: "" } }
    assert_invalid_login_response
    assert_error_message_functionality
  end

  test "login with valid email/invalid password" do
    post login_path, params: { session: { email: @user.email, password: "invalid" } }
    assert_invalid_login_response
    assert_error_message_functionality
  end

  test "login with invalid email/valid password" do
    post login_path, params: { session: { email: "", password: FIXTURE_PASSWORD } }
    assert_invalid_login_response
    assert_error_message_functionality
  end

  def assert_invalid_login_response
    assert_not is_logged_in?
    assert_response :unprocessable_entity
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
  end

  def assert_error_message_functionality
    assert_not flash.empty?, "Expected flash to show error message, but there was none."
    get root_path
    assert flash.empty?, "Expected flash message to not be visible after navigating away from login, but was not."
  end
end

class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: { session: { email: @user.email, password: FIXTURE_PASSWORD } }
  end
end

class ValidLoginTest < ValidLogin
  test "valid login" do
    assert is_logged_in?
    assert_redirected_to @user
  end

  test "redirect after login" do
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end
end

class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test "successful logout" do
    assert_not is_logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "redirect after logout" do
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "should still work after logout in second window" do
    delete logout_path
    assert_redirected_to root_url
  end
end
