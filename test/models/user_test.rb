require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name: "Example User", email: "user1@example.com", password: "fuubar",
                    password_confirmation: "fuubar")

    unless @user.valid?
      flunk("Setup failed: @user should be valid before tests run. Errors: #{@user.errors.full_messages}")
    end
  end

  test "test user should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "name cant be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email cant be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addressed = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addressed.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid."
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_adresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com
    user@example.com.]
    invalid_adresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should not be valid."
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be saved as downcase" do
    mixed_email_case = "ASddss@lko.COM"
    @user.email = mixed_email_case
    @user.save
    assert_equal mixed_email_case.downcase, @user.reload.email
  end

  test "user without password is invalid" do
    user_without_password = User.new(name: "test_user2", email: "test@email.com")
    assert_not user_without_password.valid?
  end

  test "password should be nonblank" do
    @user.password = @user.password_confirmation = " " * 10
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? returns false for a user with nil digest" do
    assert_not @user.authenticated?("")
  end
end
