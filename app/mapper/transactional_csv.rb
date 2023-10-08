# frozen_string_literal: true

class TransactionalCsv < Shale::Mapper
  attribute :transaction_id, Shale::Type::Integer
  attribute :merchant_id, Shale::Type::Integer
  attribute :user_id, Shale::Type::Integer
  attribute :card_number, Shale::Type::String
  attribute :transaction_date, Shale::Type::Time
  attribute :transaction_amount, Shale::Type::Float
  attribute :device_id, Shale::Type::Integer
  attribute :has_cbk, Shale::Type::Boolean
end
