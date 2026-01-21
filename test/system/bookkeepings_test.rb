require "application_system_test_case"

class BookkeepingsTest < ApplicationSystemTestCase
  setup do
    @bookkeeping = bookkeepings(:one)
  end

  test "visiting the index" do
    visit bookkeepings_url
    assert_selector "h1", text: "Bookkeepings"
  end

  test "should create bookkeeping" do
    visit bookkeepings_url
    click_on "New bookkeeping"

    fill_in "Amount", with: @bookkeeping.amount
    fill_in "Category", with: @bookkeeping.category
    fill_in "Date", with: @bookkeeping.date
    fill_in "Description", with: @bookkeeping.description
    fill_in "Status", with: @bookkeeping.status
    fill_in "User", with: @bookkeeping.user_id
    click_on "Create Bookkeeping"

    assert_text "Bookkeeping was successfully created"
    click_on "Back"
  end

  test "should update Bookkeeping" do
    visit bookkeeping_url(@bookkeeping)
    click_on "Edit this bookkeeping", match: :first

    fill_in "Amount", with: @bookkeeping.amount
    fill_in "Category", with: @bookkeeping.category
    fill_in "Date", with: @bookkeeping.date
    fill_in "Description", with: @bookkeeping.description
    fill_in "Status", with: @bookkeeping.status
    fill_in "User", with: @bookkeeping.user_id
    click_on "Update Bookkeeping"

    assert_text "Bookkeeping was successfully updated"
    click_on "Back"
  end

  test "should destroy Bookkeeping" do
    visit bookkeeping_url(@bookkeeping)
    click_on "Destroy this bookkeeping", match: :first

    assert_text "Bookkeeping was successfully destroyed"
  end
end
