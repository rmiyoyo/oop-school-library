require 'date'
require './rental'
require './teacher'
require './student'
require './book'

class App
  attr_reader :people

  def initialize
    @people = []
    @books = []
  end

  def show_catalogue
    @books.select { |book| puts "Title: \"#{book.title}\", Author: #{book.author}" }
  end

  def show_people
    @people.select do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.object_id}, Age: #{person.age}"
    end
  end

  def add_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    num_input = gets.chomp

    print 'Age: '
    age = gets.chomp

    print 'Name: '
    name = gets.chomp

    if num_input == '1'
      person = Student.new(age, nil, name)
      print 'Has parent permission? [Y/N]: '
      response = gets.chomp
      person.parent_permission = false if response == 'N'
      @people << person
    elsif num_input == '2'
      print 'Specialization: '
      response = gets.chomp
      person = Teacher.new(age, response, name)
      @people << person
    end
  end

  def add_catalogue
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    @books << book
  end

  def create_rental
    rental = Rental.new

    puts 'Select a book from the following list by number'
    @books.each_with_index { |book, i| puts "#{i} Title: \"#{book.title}\", Author: #{book.author}" }
    rental.book = @books[gets.chomp.to_i]
    puts ' '

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, i|
      puts "#{i}) [#{person.class}]\
    Name: #{person.name},\
    ID: #{person.object_id},\
    Age: #{person.age}"
    end
    rental.person = @people[gets.chomp.to_i]
    puts ' '

    print 'Date: '
    rental.date = Date.parse(gets.chomp)
    rental
  end

  def show_rentals_person
    print 'ID of person: '
    response = gets.chomp.to_i
    selected_person = @people.filter { |person| person.object_id == response }
    if selected_person.empty?
      puts 'Rentals: '
    else
      rentals = selected_person[0].rentals
      puts 'Rentals: '
      rentals.select { |rental| puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" }
    end
  end
end
