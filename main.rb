require_relative 'app'
require_relative 'options'
require 'json'

def main
  options = Options.new
  app = App.new

  # getting the user input
  user_input = -> { gets.chomp.to_i }

  loop do
    options.display_options
    option = user_input.call

    case option
    when 7
      app.save_data('data.json')
      puts 'Exiting the app...'
      break
    when 8
      app.load_data('data.json')
    else
      break unless options.process_option(app, option)
    end
  end
end

# Invoke the entry point method
main
