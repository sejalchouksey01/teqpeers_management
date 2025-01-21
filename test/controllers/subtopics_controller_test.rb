require "test_helper"

class SubtopicsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subtopics_index_url
    assert_response :success
  end

  test "should get new" do
    get subtopics_new_url
    assert_response :success
  end

  test "should get create" do
    get subtopics_create_url
    assert_response :success
  end
end
