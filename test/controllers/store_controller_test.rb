require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select "nav a", minimum: 4
    assert_select "main ul li", 3
    assert_select "h2", "The Pragmatic Programmer"
    assert_select "div", /\$[,\d]+\.\d\d/
  end

  test "should show visit counter after five visits" do
    6.times { get store_index_url }

    assert_response :success
    assert_select "p", /You visited this page 6 times/
  end
end
