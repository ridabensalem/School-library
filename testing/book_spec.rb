# spec/book_spec.rb
require_relative '../rental'
require_relative '../book'
require_relative '../person'
require 'date'

RSpec.describe Book do
  let(:book_title) { 'Title' }
  let(:book_author) { 'Author' }
  let(:book) { Book.new(book_title, book_author) }

  describe '#initialize' do
    it 'sets the title and author' do
      expect(book.title).to eq(book_title)
      expect(book.author).to eq(book_author)
      expect(book.rentals).to be_an(Array)
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    let(:rental_date) { Date.today }
    let(:person_name) { 'John Doe' }
    let(:person) { Person.new(person_name) }

    it 'creates a new Rental and adds it to the rentals array' do
      rental = book.add_rental(rental_date, person)

      expect(rental).to be_a(Rental)
      expect(book.rentals).to include(rental)
      expect(rental.date).to eq(rental_date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end

  describe '#rentals' do
    let(:rental1_date) { Date.today }
    let(:rental2_date) { Date.today - 7 }
    let(:person1_name) { 'John Doe' }
    let(:person2_name) { 'Jane Smith' }
    let(:person1) { Person.new(person1_name) }
    let(:person2) { Person.new(person2_name) }

    it 'returns the list of rentals for the book' do
      rental1 = book.add_rental(rental1_date, person1)
      rental2 = book.add_rental(rental2_date, person2)

      rentals = book.rentals

      expect(rentals).to be_an(Array)
      expect(rentals).to include(rental1, rental2)
      expect(rentals.size).to eq(4)
    end
  end
end
