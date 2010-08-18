require 'test_helper'

class EmergencyTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "invalid emergency with empty attributes" do
    emergency = Emergency.new
    assert !emergency.valid?
    assert emergency.errors.invalid?(:lastname)
    assert emergency.errors.invalid?(:firstname)
    assert emergency.errors.invalid?(:dayphone)
    assert emergency.errors.invalid?(:evephone)
  end
end
