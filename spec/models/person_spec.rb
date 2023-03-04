require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:fixture_path) { "#{Rails.root}/spec/fixture/csv/person" }

  describe '#import' do
    it 'run' do
      file = File.open("#{fixture_path}/basic_person.csv")
      expect {
        Person.import(file)
      }.to change { Person.count }.from(0).to(2)

      expect(Person.first.attributes).to include(
        'reference' => '1',
        'firstname' => 'Henri',
        'lastname' => 'Dupont',
        'home_phone_number' => '0123456789',
        'mobile_phone_number' => '0623456789',
        'email' => 'h.dupont@gmail.com',
        'address' => '10 Rue La bruyère'
      )
    end
  end
end
