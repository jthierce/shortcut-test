class Building < ApplicationRecord
  include BasicImport

  CSV_HEADER = [:reference, :address, :zip_code, :city, :country, :manager_name]
  HIGH_LEVEL_ATTRIBUTES = [:manager_name]
end
