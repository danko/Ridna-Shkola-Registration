require 'test_helper'

class ParentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "invalid Parent with empty attributes" do
    parent = Parent.new
    assert !parent.valid?
    assert parent.errors.invalid?(:lastname)
    assert parent.errors.invalid?(:firstname)
    assert parent.errors.invalid?(:dayphone)
    assert parent.errors.invalid?(:evephone)
    assert parent.errors.invalid?(:email)
  end
end
