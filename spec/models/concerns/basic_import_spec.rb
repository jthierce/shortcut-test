require 'rails_helper'

RSpec.describe BasicImport, type: :model do
  let(:fixture_path) { "#{Rails.root}/spec/fixture/csv/" }

  describe '#import' do
    before :each do
      Building.import(File.open("#{fixture_path}/building/basic_building.csv"))
    end

    it 'run with big file' do
      expect {
        Building.import(File.open("#{fixture_path}/building/big_files.csv"))
      }.to change { Building.count }.from(2).to(15000)
    end

    it 'update standart attribute' do
      expect(Building::HIGH_LEVEL_ATTRIBUTES).to include(:manager_name)
      expect(Building.first.zip_code).to eq('75009')
      Building.import(File.open("#{fixture_path}/building/building_1row.csv"))
      expect(Building.first.zip_code).to eq('75002')
    end

    it 'don\'t replace by nil if data is missing' do
      expect(Building.first.city).to eq('Paris')
      expect {
        Building.import(File.open("#{fixture_path}/building/empty_case_building.csv"))
      }.to change { Building.first.zip_code }.from('75009').to('75002')
      expect(Building.first.city).to eq('Paris')
    end

    context 'when we change high level attribute' do
      it 'the high level attribute already have value' do
        expect(Building::HIGH_LEVEL_ATTRIBUTES).to include(:manager_name)
        expect(Building.first.manager_name).to eq('Martin Faure')
        Building.import(File.open("#{fixture_path}/building/building_1row.csv"))
        expect(Building.first.manager_name).not_to eq('Daft Punk')
      end

      it 'the high level attribute don\t have value' do
        expect(Building::HIGH_LEVEL_ATTRIBUTES).to include(:manager_name)
        Building.first.update(manager_name: nil)
        Building.import(File.open("#{fixture_path}/building/building_1row.csv"))
        expect(Building.first.manager_name).to eq('Daft Punk')
      end
    end
  end
end
