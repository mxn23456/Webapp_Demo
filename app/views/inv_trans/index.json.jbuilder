json.array!(@inv_trans) do |inv_tran|
  json.extract! inv_tran, :id, :amount, :transaction_desc, :transaction_date, :investment_id
  json.url inv_tran_url(inv_tran, format: :json)
end
