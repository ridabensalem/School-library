require_relative '../person'
require_relative '../rental'
require_relative '../book'

RSpec.describe Rental do
  let(:date) { '1200/12/12' }
  let(:book) { Book.new('Title', 'Author-1') }
  let(:person) { Person.new('John Doe') }
  let(:rental) { Rental.new(date, book, person) }

  describe 'initialize rental' do
    it 'set the rental properties' do
      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end

    it 'adds the rental to the book' do
      expect(book.rentals).to include(rental)
    end

    it 'adds the rental to the person' do
      expect(person.rentals).to include(rental)
    end
  end
end
