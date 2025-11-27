require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = users(:testuser1)
    @user = users(:testuser2)
  end

  test "index including pagination and list of users" do
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    get users_path
    assert_template "users/index"
    assert_select "ul.pagination", count: 2
    User.page(1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      assert_select "a", text: "delete", count: 0
    end
  end

  test "index with delete links for admin" do
    log_in_with(user_email: @admin_user.email, password: FIXTURE_PASSWORD)
    get users_path
    User.page(1).each do |user|
      assert_select "a[href=?]", user_path(user), text: "delete"
    end
  end
end
