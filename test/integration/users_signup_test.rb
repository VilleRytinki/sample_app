require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    assert_no_difference "User.count" do
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_template "users/new"
    assert_select "li.error-message", 3
  end

  test "valid signup information" do
    before = User.count

    post users_path, params: {
      user: {
        name: "valid_user",
        email: "valid@validuser.com",
        password: "testuser123",
        password_confirmation: "testuser123"
      }
    }

    after = User.count
    user = assigns(:user)

      message = if after == before && user
              "Expected User.count to increase by 1, but it didn’t.\n" \
              "Validation errors: #{user.errors.full_messages.join(', ')}"
      else
              "Expected User.count to increase by 1."
      end

  assert_equal before + 1, after, message
  assert_redirected_to user_path(User.last)
  follow_redirect!
  # The flash should appear once
  assert_select "div.alert-success", text: "Welcome to the Sample App!"

  # Simulate refreshing the page (a second GET request to the same URL)
  get user_path(User.last)

  # The flash should now be gone
  assert_select "div.alert-success", false, "Flash should not persist after refresh"
  assert is_logged_in?, "Expected user to be logged in after signup, but was not."
end
end
