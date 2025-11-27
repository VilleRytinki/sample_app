require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    get root_path
  end

  test "root path renders home template" do
    assert_template "static_pages/home"
  end

  test "layout file has 2 root navigation links" do
    assert_select "a[href=?]", root_path, count: 2
  end

  test "layout file has link to help page" do
    assert_select "a[href=?]", help_path
  end

  test "layout file has link to about page" do
    assert_select "a[href=?]", about_path
  end

  test "layout file has link to contact page" do
    assert_select "a[href=?]", contact_path
  end

  test "layout file has link to signup page" do
    assert_select "a[href=?]", signup_path
  end

  test "layout file has link to login page" do
    assert_select "a[href=?]", login_path
  end
end

class NavigationLayoutTestsLoggedInUser < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser1)
    log_in_with(user_email: @user.email, password: FIXTURE_PASSWORD)
    get root_url
  end

  test "layout has a link to users" do
    assert_select "a[href=?]", users_path
  end

  test "layout has account menu navigation link" do
    assert_select "a", { count: 1, text: "Account" }
  end

  test "layout has navigation item for profile" do
    assert_select "a[href=?]", user_path(@user)
  end

  test "layout has navigation link to settings" do
    assert_select "a[href=?]", edit_user_path(@user)
  end

  test "layout has link to logout" do
    assert_select "a[href=?]", logout_path
  end
end
