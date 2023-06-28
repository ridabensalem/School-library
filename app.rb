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
    create_json_files
    load_data('./data/books.json', './data/rentals.json', './data/people.json')
  end

  def create_json_files
    Dir.mkdir('./data') unless Dir.exist?('./data')
    create_file_if_not_exists('./data/books.json', [])
    create_file_if_not_exists('./data/rentals.json', [])
    create_file_if_not_exists('./data/people.json', [])
  end

  def create_file_if_not_exists(file_path, default_data)
    return if File.exist?(file_path)

    File.write(file_path, JSON.generate(default_data))
    puts "Created #{file_path} file."
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
      classroom = gets.chomp
      puts 'Does the student have parent permission (true/false):'
      parent_permission = gets.chomp

      student = Student.new(@people.length + 1, name, age, classroom: classroom, parent_permission: parent_permission)

      # Load existing people data from the JSON file
      people_data = JSON.parse(File.read('./data/people.json'))

      person_data = {
        'id' => student.id,
        'name' => student.name,
        'age' => student.age,
        'classroom' => student.classroom,
        'parent_permission' => student.parent_permission,
        'rentals' => student.rentals
      }

      # Add the new person object to the existing array
      people_data << person_data

      # Write the updated array back to the JSON file
      File.write('./data/people.json', JSON.generate(people_data))

      puts 'Student created successfully!'
    elsif person_type == 'teacher'
      puts 'Enter specialization:'
      specialization = gets.chomp

      teacher = Teacher.new(@people.length + 1, name, age, specialization: specialization)

      # Load existing people data from the JSON file
      people_data = JSON.parse(File.read('./data/people.json'))

      person_data = {
        'id' => teacher.id,
        'name' => teacher.name,
        'age' => teacher.age,
        'specialization' => teacher.specialization,
        'rentals' => teacher.rentals
      }

      # Add the new person object to the existing array
      people_data << person_data

      # Write the updated array back to the JSON file
      File.write('./data/people.json', JSON.generate(people_data))

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

    # Load existing books data from the JSON file
    books_data = JSON.parse(File.read('./data/books.json'))

    book_data = {
      'title' => book.title,
      'author' => book.author,
      'rentals' => book.rentals
    }

    # Add the new book object to the existing array
    books_data << book_data

    # Write the updated array back to the JSON file
    File.write('./data/books.json', JSON.generate(books_data))

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

        # Load existing rentals data from the JSON file
        rentals_data = JSON.parse(File.read('./data/rentals.json'))

        rental_data = {
          'date' => rental.date,
          'book' => {
            'title' => rental.book.title,
            'author' => rental.book.author,
            'rentals' => rental.book.rentals
          },
          'person' => {
            'id' => rental.person.id,
            'name' => rental.person.name,
            'age' => rental.person.age,
            'classroom' => rental.person.classroom,
            'parent_permission' => rental.person.parent_permission,
            'rentals' => rental.person.rentals
          }
        }

        # Add the new rental object to the existing array
        rentals_data << rental_data

        # Write the updated array back to the JSON file
        File.write('./data/rentals.json', JSON.generate(rentals_data))

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
