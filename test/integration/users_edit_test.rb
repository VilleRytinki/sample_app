require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
  end

  test "unsuccessful edit renders the edit page with error messages" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD, remember_me: "0")
    get edit_user_path(@user)
    assert_template "users/edit"

    patch user_path(@user), params: {
      user: {
        name: "",
        email: "foo@invalid.com",
        password: "foo",
        password_confirmation: "bar"
      }
    }

    assert_template "users/edit"
    assert_select "li.error-message"
  end

  test "successful edit loads the user profile page and updates user information in db" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD, remember_me: "0")
    new_name = "UpdatedName"
    new_email = "mynewemail@myemailservice.com"
    patch user_path(@user), params: {
      user: {
        name: new_name,
        email: new_email,
        password: "",
        password_confirmation: ""
      }
    }
    user = assigns(:user)
    assert_not flash.empty?, "Expected flash message to not be empty. #{user.errors.full_messages}"
    assert_redirected_to @user, "Expected to be redirected to user profile page. #{user.errors.full_messages}"
    @user.reload
    assert_equal new_name, @user.name
    assert_equal new_email, @user.email
  end

  test "friendly forwarding" do
    get edit_user_path(@user)
    assert_redirected_to login_path

    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD, remember_me: "0")
    assert_redirected_to edit_user_path(@user)
    assert session[:forwarding_url].nil?, "forwarding url should be nil after successful forwarding."
  end

    test "should not allow editing of admin attribute via web" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    assert_not @user.admin?

    patch user_path(@user), params: {
      user: {
        password: FIXTURE_PASSWORD,
        password_confirmation: FIXTURE_PASSWORD,
        admin: true
      }
    }

    admin_status_changed = @user.reload.admin?

    assert_not admin_status_changed, "Admin role should not be allowed to edit via web but is changed."
  end
end
