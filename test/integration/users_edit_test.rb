require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
  end

  test "unsuccessful edit renders the edit page with error messages" do
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
end
