# frozen_string_literal: true

require 'csv'

csv_text = File.read(Rails.root.join('db/transactional-sample.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

merchant_ids = csv.map { |row| row['merchant_id'].to_i }.uniq.sort

merchant_ids.each do |merchant_id|
  Merchant.create!(id: merchant_id, name: Faker::Company.name)
end

user_ids = csv.map { |row| row['user_id'].to_i }.uniq.sort

user_ids.each do |user_id|
  User.create!(id: user_id, name: Faker::Name.name)
end

devices = csv.map do |row|
  [row['device_id'].to_i, row['user_id'].to_i] if row['device_id']
end

devices.compact.sort_by { |a| a[0] }.each do |device_id, user_id|
  next if Device.exists?(id: device_id)

  Device.create!(id: device_id,
                 user_id:,
                 name: 'Mobile',
                 ip: Faker::Internet.ip_v4_address)
end

csv.each do |row|
  Transaction.create!(id: row['transaction_id'].to_i,
                      user_id: row['user_id'].to_i,
                      merchant_id: row['merchant_id'].to_i,
                      amount: row['transaction_amount'].to_d,
                      card_number: row['card_number'],
                      device_id: row['device_id']&.to_i,
                      reference_at: row['transaction_date'],
                      has_cbk: row['has_cbk'])
end
