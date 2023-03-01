class Person < ApplicationRecord
    high_level_attribute :email, :mobile_phone_number, :home_phone_number, :address

    #before_save
end
