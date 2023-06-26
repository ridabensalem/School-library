require_relative 'app'
require_relative 'options'

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

def main
  options = Options.new
  app = App.new
  # getting the user input
  user_input = -> { gets.chomp.to_i }

  loop do
    options.display_options
    option = user_input.call
    break unless process_option(app, option)
  end
end

# Invoke the entry point method
main
