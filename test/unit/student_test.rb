require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "invalid Student with empty attributes" do
    student = Student.new
    assert !student.valid?
    assert student.errors.invalid?(:lastname)
    assert student.errors.invalid?(:firstname)
    assert student.errors.invalid?(:gender)
    assert student.errors.invalid?(:birthdate)
    assert student.errors.invalid?(:newgrade)
    assert student.errors.invalid?(:userid)
    assert student.errors.invalid?(:studentid)
  end  
end
