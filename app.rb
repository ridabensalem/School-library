require_relative 'person'
require_relative 'student'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require_relative 'loader'
require 'json'

class App
  include Loader

  def initialize
    @people = []
    @books = []
    @rentals = []
    load_data('./data/books.json', './data/rentals.json', './data/people.json')
  end

  def list_books
    puts 'List of Books:'
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    puts 'List of People:'
    @people.each do |person|
      puts "ID: #{person.id}, Name: #{person.name}"
    end
  end

  def create_person
    puts 'Enter person type (student or teacher):'
    person_type = gets.chomp.downcase
    puts 'Enter person name:'
    name = gets.chomp
    puts 'Enter person age:'
    age = gets.chomp.to_i
    if person_type == 'student'
      puts 'Enter classroom:'
      class_name = gets.chomp
      puts 'Student has parent permission :'
      permission = gets.chomp
      student = Student.new(@people.length + 1, name, age, classroom: class_name, parent_permission: permission)

      @people << { 'id' => student.id, 'name' => student.name, 'age' => student.age, 'parent_permission' => student.parent_permission, 'rentals' => student.rentals }

      File.write('./data/people.json', JSON.generate(@people))

      puts 'Student created successfully!'

    elsif person_type == 'teacher'
      puts 'Enter specialization:'
      specialization = gets.chomp
      teacher = Teacher.new(@people.length + 1, name, age, specialization: specialization)

      @people <<  { 'id' => teacher.id, 'name' => teacher.name, 'age' => teacher.age, 'specialization' => teacher.specialization, 'rentals' => teacher.rentals }

      File.write('./data/people.json', JSON.generate(@people))

      puts 'Teacher created successfully!'
    else
      puts 'Invalid person type.'
    end
  end

  def create_book
    puts 'Enter book title:'
    title = gets.chomp
    puts 'Enter book author:'
    author = gets.chomp

    book = Book.new(title, author)
    @books << { 'title' => book.title, 'author' => book.author, 'rentals' => book.rentals }
    File.write('./data/books.json', JSON.generate(@books))
    puts 'Book created successfully!'
  end

  def create_rental
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    person = find_person_by_id(person_id)
    if person.nil?
      puts 'Person not found.'
    else
      puts 'Enter book title:'
      book_title = gets.chomp
      book = find_book_by_title(book_title)
      if book.nil?
        puts 'Book not found.'
      else
        puts 'Enter rental date (YYYY-MM-DD):'
        date = gets.chomp
  
        rental = Rental.new(date, book, person)
        @rentals <<  { 'date' => rental.date, 'book' => rental.book, 'person' => rental.person }
        File.write('./data/rentals.json', JSON.generate(@rentals))
        puts 'Rental created successfully!'
      end
    end
  end  

  def list_rentals_for_person
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }

    return if person.nil?

    puts "Rentals for Person ID #{person_id}:"
    person.rentals.each do |rental|
      puts "Name: #{rental.person.name} Book: #{rental.book.title}, Rental Date: #{rental.date}"
    end
  end
end
