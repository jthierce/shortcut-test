module BasicImport
  extend ActiveSupport::Concern

  included do
    def self.import file
      csv = CSV.parse(file, headers: true)
      csv.each do |row|
        next if row['reference'].nil?
        model = self.new()
        model ||= self.where(reference: row['reference'])
        CSV_HEADER.each do |attribute|
          model[attribute] = row[attribute.to_s] if !row[attributes.to_s].nil? && can_update_high_level_attributes?(model, attribute)
        end
        put building_hash
      end
    end

    private

    def can_update_high_level_attributes?(model, attribute)
      return true unless attribue.include?(HIGH_LEVEL_ATTRIBUTES)
      return false unless model.attributes.blank?
    end
  end
end