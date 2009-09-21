require 'test_helper'

class PasswordMailerTest < ActionMailer::TestCase
  test "forgot" do
    @expected.subject = 'PasswordMailer#forgot'
    @expected.body    = read_fixture('forgot')
    @expected.date    = Time.now

    assert_equal @expected.encoded, PasswordMailer.create_forgot(@expected.date).encoded
  end

end
