json.extract! invoice, :id, :user_id, :student_id, :meeting_date_1, :meeting_date_2, :meeting_date_3, :meeting_date_4, :amount, :status, :created_at, :updated_at
json.url invoice_url(invoice, format: :json)
