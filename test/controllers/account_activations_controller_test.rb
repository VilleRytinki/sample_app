require "test_helper"

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    post users_path, params: {
      user: {
        name: "AccountActivationUser",
        email: "activationuser@email.com",
        password: "password",
        password_confirmation: "password"
      }
    }

    @user = assigns(:user)
  end

  def assert_account_activation_failed
    assert_redirected_to root_url
    follow_redirect!
    assert_select "div.alert-danger", text: "Invalid activation link"
    assert_equal false, @user.reload.activated?, "user was activated."
  end

  test "mail queue should be increased by one on user signup" do
    assert_equal 1, ActionMailer::Base.deliveries.size
  end

  test "user should not be able to activate account with invalid email" do
    get edit_account_activation_url(@user.activation_token, email: "something@else.com")
    assert_account_activation_failed
  end

  test "user should not be able to activate account with invalid token" do
    get edit_account_activation_url("oifja3", email: @user.email)
    assert_account_activation_failed
  end

  test "user should be able to activate account with valid token and email" do
    get edit_account_activation_url(@user.activation_token, email: @user.email)
    assert_equal true, @user.reload.activated?, "User was not activated."
    assert is_logged_in?
    assert_redirected_to user_path(@user)
    follow_redirect!
    assert_select "div.alert-success", text: "Account activated!"
  end
end
