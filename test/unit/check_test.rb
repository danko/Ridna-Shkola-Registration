require 'test_helper'

class CheckTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "invalid with empty attributes" do
    check = Check.new
    assert !check.valid?
    assert check.errors.invalid?(:userid)
    assert check.errors.invalid?(:amount)
    assert check.errors.invalid?(:checknumber)
  end
end
