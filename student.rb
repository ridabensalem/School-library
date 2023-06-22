require_relative 'person'
class Student < Person
  attr_accessor :classroom

  def initialize(id, name = 'Unknown', age = 0, classroom: '', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @id = id
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
