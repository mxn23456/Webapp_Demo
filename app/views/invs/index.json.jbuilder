json.array!(@invs) do |inv|
  json.extract! inv, :id, :inv_desc, :notes
end
