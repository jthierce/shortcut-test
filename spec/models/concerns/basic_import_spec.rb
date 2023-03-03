require 'rails_helper'

RSpec.describe BasicImport, type: :model do
  let(:fixture_path) { "#{Rails.root}/spec/fixture/csv/" }

  describe '#import' do
    context 'when the class is user' do
      it 'run' do
        file = File.open("#{fixture_path}/person/basic_person.csv")
        expect {
          Person.import(file)
        }.to change { Person.count }.from(0).to(2)
      end
    end
  end
end
