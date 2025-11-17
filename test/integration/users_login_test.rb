require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
  end
  test "login with invalid information" do
    get login_path
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    post login_path, params: { session: { email: "", password: "" } }
    assert_response :unprocessable_entity
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    assert_not flash.empty?, "Expected flash to show error message, but there was none."
    get root_path
    assert flash.empty?, "Expected flash message to not be visible after navigating away from login, but was not."
  end

  test "login with invalid password information" do
    get login_path
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    post login_path, params: { session: { email: @user.email, password: "invalid" } }
    assert_response :unprocessable_entity
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    assert_not flash.empty?, "Expected flash to show error message, but there was none."
    get root_path
    assert flash.empty?, "Expected flash message to not be visible after navigating away from login, but was not."
  end

  test "login with invalid email information" do
    get login_path
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    post login_path, params: { session: { email: "", password: FIXTURE_PASSWORD } }
    assert_response :unprocessable_entity
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    assert_not flash.empty?, "Expected flash to show error message, but there was none."
    get root_path
    assert flash.empty?, "Expected flash message to not be visible after navigating away from login, but was not."
  end

  test "login with valid information" do
    user = users(:testuser1)
    get login_path
    assert_template "sessions/new", "Expected correct template to be rendered, but was not"
    post login_path, params: { session: { email: @user.email, password: FIXTURE_PASSWORD } }
    assert_redirected_to user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(user)
  end
end
