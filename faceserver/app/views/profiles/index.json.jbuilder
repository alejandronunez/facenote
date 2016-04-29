json.array!(@profiles) do |profile|
  json.extract! profile, :id, :firstname, :surname, :age, :gender, :birday
  json.url profile_url(profile, format: :json)
end
