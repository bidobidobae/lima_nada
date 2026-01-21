json.extract! bookkeeping, :id, :date, :amount, :status, :type, :description, :user_id, :created_at, :updated_at
json.url bookkeeping_url(bookkeeping, format: :json)
