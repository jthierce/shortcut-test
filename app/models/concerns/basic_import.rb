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
          change_value(model, attribute, row[attribute.to_s]) if !row[attribute.to_s].nil? && can_update_high_level_attributes?(model, attribute, row[attribute.to_s])
        end
        model.save
      end
    end

    private

    def self.can_update_high_level_attributes?(model, attribute, value)
      return true unless self::HIGH_LEVEL_ATTRIBUTES.include?(attribute)
      return false if model.send("old_#{attribute}").include?(value)
      return true

    rescue => e
      Rails.logger.error("The High attribute doesn't have the field old, make the migration for this") if e.message.match?(/undefined method.*old/)
      raise e
    end

    def self.change_value(model, attribute, value)
      model.send("old_#{attribute}") << model[attribute] if self::HIGH_LEVEL_ATTRIBUTES.include?(attribute)
      model[attribute] = value
    end
  end
end