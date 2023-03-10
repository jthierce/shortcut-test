require 'rails_helper'

RSpec.describe BasicImport, type: :model do
  let(:fixture_path) { "#{Rails.root}/spec/fixture/csv/" }

  describe '#import' do
    before :each do
      Building.import(File.open("#{fixture_path}/building/basic_building.csv"))
    end

    it 'run with big file' do
      time = Time.now
      expect {
        Building.import(File.open("#{fixture_path}/building/big_files.csv"))
      }.to change { Building.count }.from(2).to(15000)
      time = Time.now - time
      expect(time).to be <= 60
    end

    it 'update standart attribute' do
      expect(Building::HIGH_LEVEL_ATTRIBUTES).not_to include(:zip_code)
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
      it 'the high level attribute already have this value before' do
        expect(Building::HIGH_LEVEL_ATTRIBUTES).to include(:manager_name)
        Building.import(File.open("#{fixture_path}/building/building_1row.csv"))
        expect(Building.first.manager_name).to eq('Daft Punk')
        expect(Building.first.old_manager_name).to eq(['Martin Faure'])
        Building.import(File.open("#{fixture_path}/building/basic_building.csv"))
        expect(Building.first.manager_name).not_to eq('Martin Faure')
      end

      it 'the high level attribute don\t have this value before' do
        expect(Building::HIGH_LEVEL_ATTRIBUTES).to include(:manager_name)
        Building.first.update(manager_name: nil, old_manager_name: ['Martin Faure'])
        Building.import(File.open("#{fixture_path}/building/building_1row.csv"))
        expect(Building.first.manager_name).to eq('Daft Punk')
      end
    end
  end
end
