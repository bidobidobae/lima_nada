require "test_helper"

class BookkeepingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bookkeeping = bookkeepings(:one)
  end

  test "should get index" do
    get bookkeepings_url
    assert_response :success
  end

  test "should get new" do
    get new_bookkeeping_url
    assert_response :success
  end

  test "should create bookkeeping" do
    assert_difference("Bookkeeping.count") do
      post bookkeepings_url, params: { bookkeeping: { amount: @bookkeeping.amount, category: @bookkeeping.category, date: @bookkeeping.date, description: @bookkeeping.description, status: @bookkeeping.status, user_id: @bookkeeping.user_id } }
    end

    assert_redirected_to bookkeeping_url(Bookkeeping.last)
  end

  test "should show bookkeeping" do
    get bookkeeping_url(@bookkeeping)
    assert_response :success
  end

  test "should get edit" do
    get edit_bookkeeping_url(@bookkeeping)
    assert_response :success
  end

  test "should update bookkeeping" do
    patch bookkeeping_url(@bookkeeping), params: { bookkeeping: { amount: @bookkeeping.amount, category: @bookkeeping.category, date: @bookkeeping.date, description: @bookkeeping.description, status: @bookkeeping.status, user_id: @bookkeeping.user_id } }
    assert_redirected_to bookkeeping_url(@bookkeeping)
  end

  test "should destroy bookkeeping" do
    assert_difference("Bookkeeping.count", -1) do
      delete bookkeeping_url(@bookkeeping)
    end

    assert_redirected_to bookkeepings_url
  end
end
