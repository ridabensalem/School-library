# spec/person_spec.rb
require_relative '../nameable'
require_relative '../rental'
require_relative '../person'
require_relative '../book'
require 'date'

RSpec.describe Person do
  let(:age) { 25 }
  let(:name) { 'John Doe' }
  let(:parent_permission) { true }
  let(:person) { Person.new(age, name, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the age, name, parent_permission, rentals, and generates an ID' do
      expect(person.age).to eq(age)
      expect(person.name).to eq(name)
      expect(person.instance_variable_get(:@parent_permission)).to eq(parent_permission)
      expect(person.rentals).to be_an(Array)
      expect(person.rentals).to be_empty
      expect(person.instance_variable_get(:@id)).to be_an(Integer)
    end

    context 'when name is not provided' do
      let(:person) { Person.new(age) }

      it 'sets the name to "Unknown"' do
        expect(person.name).to eq('Unknown')
      end
    end
  end

  describe '#add_rental' do
    let(:rental) { Rental.new(Date.today, Book.new('Book Title', 'Book Author'), person) }

    it 'adds the rental to the rentals array' do
      person.add_rental(rental)

      expect(person.rentals).to include(rental)
    end
  end
end
