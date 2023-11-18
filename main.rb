require_relative 'app'

class Launch
  def menu
    [
      'List all books',
      'List all people',
      'Create a person',
      'Create a book',
      'Create a rental',
      'List all rentals for a given person id',
      'Exit'
    ]
  end

  def show_menu
    puts 'Please choose an option by entering a number: '
    menu.each_with_index { |option, i| puts "#{i + 1} - #{option}" }
  end

  def choices
    {
      '1' => -> { @app.show_catalogue },
      '2' => -> { @app.show_people },
      '3' => lambda {
        @app.add_person
        puts 'Person created successfully\n'
      },
      '4' => lambda {
        @app.add_catalogue
        puts 'Book created successfully\n'
      },
      '5' => lambda {
        @app.create_rental
        puts 'Rental created successfully\n'
      },
      '6' => -> { @app.show_rentals_person },
      '7' => -> { puts 'Exiting... Thank you for using the app!' }
    }
  end

  def main
    @app = App.new
    calls = choices
    loop do
      show_menu
      choose = gets.chomp
      if calls[choose]
        calls[choose].call
        return if choose == '7'
      else
        puts 'Error, you have entered a wrong choice'
      end

      puts ' '
    end
  end
end

beginning = Launch.new
beginning.main
