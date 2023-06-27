require_relative 'person'
require_relative 'student'
require_relative 'book'
require_relative 'rental'
require_relative 'teacher'
require 'json'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
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
      puts 'Student has parent permission:'
      permission = gets.chomp
      student = Student.new(@people.length + 1, name, age, classroom: class_name, parent_permission: permission)
      @people << student
      puts 'Student created successfully!'
    elsif person_type == 'teacher'
      puts 'Enter specialization:'
      specialization = gets.chomp
      teacher = Teacher.new(@people.length + 1, name, age, specialization: specialization)
      @people << teacher
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
    @books << book
    puts 'Book created successfully!'
  end

  def create_rental
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    person = @people.find { |p| p.id == person_id }
    if person.nil?
      puts 'Person not found.'
    else
      puts 'Enter book title:'
      book_title = gets.chomp
      book = @books.find { |b| b.title == book_title }
      if book.nil?
        puts 'Book not found.'
      else
        puts 'Enter rental date (YYYY-MM-DD):'
        date = gets.chomp

        rental = Rental.new(date, book, person)
        @rentals << rental
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
      puts "Book: #{rental.book.title}, Rental Date: #{rental.date}"
    end
  end

  def save_data(file_path)
    data = {
      people: @people,
      books: @books,
      rentals: @rentals
    }

    File.write(file_path, JSON.generate(data))

    puts 'Data saved successfully!'
  end

  def load_data(file_path)
    data = JSON.parse(File.read(file_path))

    @people = data['people'].map do |person_data|
      if person_data['classroom']
        Student.new(person_data['id'], person_data['name'], person_data['age'], classroom: person_data['classroom'],
                                                                                parent_permission: person_data['parent_permission'])
      else
        Teacher.new(person_data['id'], person_data['name'], person_data['age'],
                    specialization: person_data['specialization'])
      end
    end

    @books = data['books'].map do |book_data|
      Book.new(book_data['title'], book_data['author'])
    end

    @rentals = data['rentals'].map do |rental_data|
      book = @books.find { |b| b.title == rental_data['book']['title'] }
      person = @people.find { |p| p.id == rental_data['person']['id'] }
      Rental.new(rental_data['date'], book, person)
    end

    puts 'Data loaded successfully!'
  end
end
