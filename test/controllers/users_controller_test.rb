require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
    @user2 = users(:testuser2)
  end
  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", full_title("Sign Up")
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as a wrong user" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    get edit_user_path(@user2)

    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as a wrong user" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    patch user_path(@user2), params: {
      user: {
        name: @user2.name,
        email: @user2.email
      }
    }

    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should render index when logged in for users" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    get users_path
    assert_template "users/index"
  end
end
