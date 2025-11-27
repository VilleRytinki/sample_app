require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
  end

  test "index including pagination and list of users" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    get users_path
    assert_template "users/index"
    assert_select "ul.pagination", count: 2
    User.page(1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
    end
  end
end
