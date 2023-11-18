require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(id, classroom, name = 'Unknown', age = 0, parent_permission: true)
    super(id, name, age, parent_permission)
    @classroom = classroom
  end

  def correct_name
    @name
  end

  def play_hooky
    '¯(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.include?(self)
  end
end
