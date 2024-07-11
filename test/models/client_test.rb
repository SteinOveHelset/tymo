require "test_helper"

class ClientTest < ActiveSupport::TestCase
  test "should not save client without title and description" do
    client = Client.new
    assert_not client.save, "Saved the client without a title and description"
  end
end
