class Options
  def display_options
    puts 'Choose an option:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Quit'
  end

  def process_option(app, option)
    actions = {
      1 => -> { app.list_books },
      2 => -> { app.list_people },
      3 => -> { app.create_person },
      4 => -> { app.create_book },
      5 => -> { app.create_rental },
      6 => -> { app.list_rentals_for_person },
      7 => -> { puts 'Exiting the app...' }
    }
  
    # making choice conditons
    action = actions[option]
    if action
      action.call
      option != 7
    else
      puts 'Invalid option. Please try again.'
      true
    end
  end
end
