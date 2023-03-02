class Person < ApplicationRecord
  high_level_attribute :email, :mobile_phone_number, :home_phone_number, :address

  def self.import file
    csv = CSV.parse(file, headers: true)
    csv.each do |row|
      person_hash = {}
      person_hash[:reference] = row[:reference]
      person_hash[:firstname] = row[:firstname]
      person_hash[:lastname] = row[:lastname]
      person_hash[:home_phone_number] = row[:home_phone_number]
      person_hash[:mobile_phone_number] = row[:mobile_phone_number]
      person_hash[:email] = row[:email]
      person_hash[:address] = row[:address]
  end
end
