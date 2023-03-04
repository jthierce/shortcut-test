require 'rails_helper'

RSpec.describe Building, type: :model do
  let(:fixture_path) { "#{Rails.root}/spec/fixture/csv/building" }

  describe '#import' do
    it 'run' do
      file = File.open("#{fixture_path}/basic_building.csv")
      expect {
        Building.import(file)
      }.to change { Building.count }.from(0).to(2)

      expect(Building.first.attributes).to include(
        'reference' => '1',
        'address' => '10 Rue La bruyère',
        'zip_code' => '75009',
        'city' => 'Paris',
        'country' => 'France',
        'manager_name' => 'Martin Faure'
      )
    end
  end
end
