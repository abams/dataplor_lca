require "test_helper"

class NodeControllerTest < ActionDispatch::IntegrationTest
  test "returns 404 if missing params" do
    get "/nodes/common_anscestor"
    
    assert_response :not_found
  end

  test "returns 404 if node_a not found" do
    # binding.pry
    get "/nodes/common_anscestor?a=#{nodes(:top).id}"
    
    assert_response :not_found
  end

  test "returns 404 if node_b not found" do
    get "/nodes/common_anscestor?b=#{nodes(:top).id}"
    
    assert_response :not_found
  end

  test "returns 200 if two present nodes found" do 
    get "/nodes/common_anscestor?b=#{nodes(:top).id}&b=#{nodes(:top).id}"

    assert_response :success
  end

  # test "node is child of parent" { }
  # test "same node" {}
  # # test "returns success if both nodes exist" do 
  #   get "/nodes/common_anscestor?b=#{nodes(:top).id}&b="

  # end
end
