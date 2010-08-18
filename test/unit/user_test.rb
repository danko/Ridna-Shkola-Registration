require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "invalid User with empty attributes" do
    user = User.new
    assert !user.valid?
    assert user.errors.invalid?(:login)
    assert user.errors.invalid?(:email)
    assert user.errors.invalid?(:userid)
    assert user.errors.invalid?(:family)
    assert user.errors.invalid?(:street)
    assert user.errors.invalid?(:city)
    assert user.errors.invalid?(:state)
    assert user.errors.invalid?(:zip)
    assert user.errors.invalid?(:phonenum)
  end
  
  test "invalid user with blank password" do
    user = User.new(:login => "mytest",
                    :email => "mytest@gmail.com",
                    :userid => "6789",
                    :family => "mytest",
                    :street => "mytest",
                    :city => "mytest",
                    :state => "mytest",
                    :zip => "mytest",
                    :phonenum => "mytest") 
    user.password = ""
    assert !user.valid?
    assert user.errors.invalid?(:password)
  end
end
