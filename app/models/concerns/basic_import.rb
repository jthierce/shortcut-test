module BasicImport
  extend ActiveSupport::Concern

  included do
    def self.import file
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        next if row['reference'].nil?
        model = self.where(reference: row['reference']).first
        model = self.new() if model.blank?
        self::CSV_HEADER.each do |attribute|
          model[attribute] = row[attribute.to_s] if !row[attribute.to_s].nil? && can_update_high_level_attributes?(model, attribute)
        end
        model.save
      end
    end

    def self.can_update_high_level_attributes?(model, attribute)
      return true unless self::HIGH_LEVEL_ATTRIBUTES.include?(attribute)
      return false unless model.attributes.blank?
    end
  end
end