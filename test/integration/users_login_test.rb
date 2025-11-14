require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end
