require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_invoice_url
    assert_response :success
  end

  test "should create invoice" do
    assert_difference("Invoice.count") do
      post invoices_url, params: { invoice: { amount: @invoice.amount, meeting_date_1: @invoice.meeting_date_1, meeting_date_2: @invoice.meeting_date_2, meeting_date_3: @invoice.meeting_date_3, meeting_date_4: @invoice.meeting_date_4, status: @invoice.status, student_id: @invoice.student_id, user_id: @invoice.user_id } }
    end

    assert_redirected_to invoice_url(Invoice.last)
  end

  test "should show invoice" do
    get invoice_url(@invoice)
    assert_response :success
  end

  test "should get edit" do
    get edit_invoice_url(@invoice)
    assert_response :success
  end

  test "should update invoice" do
    patch invoice_url(@invoice), params: { invoice: { amount: @invoice.amount, meeting_date_1: @invoice.meeting_date_1, meeting_date_2: @invoice.meeting_date_2, meeting_date_3: @invoice.meeting_date_3, meeting_date_4: @invoice.meeting_date_4, status: @invoice.status, student_id: @invoice.student_id, user_id: @invoice.user_id } }
    assert_redirected_to invoice_url(@invoice)
  end

  test "should destroy invoice" do
    assert_difference("Invoice.count", -1) do
      delete invoice_url(@invoice)
    end

    assert_redirected_to invoices_url
  end
end
