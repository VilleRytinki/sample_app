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
end
