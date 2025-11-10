require "test_helper"

class ApplicationHelperTest < ActionDispatch::IntegrationTest
  test "returns base title when no input" do
    assert_equal "Ruby on Rails Tutorial Sample App", full_title
  end

  test "returns full title with an input parameter" do
    assert_equal "Example | Ruby on Rails Tutorial Sample App", full_title("Example")
  end
end
