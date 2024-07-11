require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test "should not save team without title" do
    team = Team.new
    assert_not team.save
  end
end
