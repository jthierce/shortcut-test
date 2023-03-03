class Person < ApplicationRecord
  include BasicImport

  CSV_HEADER = [:reference, :firstname, :lastname, :home_phone_number, :mobile_phone_number, :email, :address]
  HIGH_LEVEL_ATTRIBUTES = [:email, :mobile_phone_number, :home_phone_number, :address]
end
