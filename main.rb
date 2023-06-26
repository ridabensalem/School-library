require_relative 'app'
require_relative 'options'

def main
  options = Options.new
  app = App.new
  # getting the user input
  user_input = -> { gets.chomp.to_i }

  loop do
    options.display_options
    option = user_input.call
    break unless options.process_option(app, option)
  end
end

# Invoke the entry point method
main
