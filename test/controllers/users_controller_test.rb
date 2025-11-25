require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
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
end
