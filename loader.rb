module Loader
  def data_files_exist?(book, rentals, people)
    if File.exist?(book) && File.exist?(book) && File.exist?(book)
  end

  def load_books(books_file)
    books_data = JSON.parse(File.read(books_file))
    books_data.map do |book_data|
      Book.new(book_data['title'], book_data['author'])
    end
  end

  def load_people(people_file)
    people_data = JSON.parse(File.read(people_file))
    people_data.map do |person_data|
      create_person_from_data(person_data)
    end.compact
  end

  def create_person_from_data(person_data)
    if person_data.is_a?(String)
      nil
    elsif person_data.key?('classroom')
      Student.new(
        person_data['id'],
        person_data['name'],
        person_data['age'],
        classroom: person_data['classroom'],
        parent_permission: person_data['parent_permission']
      )
    else
      Teacher.new(
        person_data['id'],
        person_data['name'],
        person_data['age'],
        specialization: person_data['specialization']
      )
    end
  end

  def load_rentals(rentals_file)
    rentals_data = JSON.parse(File.read(rentals_file))
    rentals_data.map do |rental_data|
      book_data = rental_data['book']
      person_data = rental_data['person']
      next if book_data.nil? || person_data.nil?

      book = find_book_by_title(book_data['title'])
      person = find_person_by_id(person_data['id'])
      Rental.new(rental_data['date'], book, person) if book && person
    end.compact
  end

  def find_book_by_title(title)
    @books.find { |book| book.title == title }
  end

  def find_person_by_id(id)
    @people.find do |person|
      id_value = person.is_a?(Hash) ? person['id'] : person.id
      id_value == id
    end
  end

  def load_data(books_file, rentals_file, people_file)
    if data_files_exist?(books_file, rentals_file, people_file)
      @books = load_books(books_file)
      @people = load_people(people_file)
      @rentals = load_rentals(rentals_file)

      puts 'Data loaded successfully!'
    else
      puts 'No data files found. Starting with empty data.'
    end
  end
end
