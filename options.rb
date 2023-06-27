class Options
  def display_options
    puts 'Choose an option:'
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List rentals for a person'
    puts '7. Save data'
    puts '8. Load data'
    puts '9. Quit'
  end

  def process_option(app, option)
    actions = {
      1 => -> { app.list_books },
      2 => -> { app.list_people },
      3 => -> { app.create_person },
      4 => -> { app.create_book },
      5 => -> { app.create_rental },
      6 => -> { app.list_rentals_for_person },
      7 => -> { puts 'Data saved.' },
      8 => -> { puts 'Data loaded.' },
      9 => -> { puts 'Exiting the app...' }
    }

    # making choice conditions
    action = actions[option]
    if action
      action.call
      option != 9
    else
      puts 'Invalid option. Please try again.'
      true
    end
  end
end
