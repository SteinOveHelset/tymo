require "test_helper"

class ProjectTest < ActiveSupport::TestCase
  test "should not save project without title and description" do
    project = Project.new
    assert_not project.save, "Saved the cliprojectent without a title and description"
  end
end
