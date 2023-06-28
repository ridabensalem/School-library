require_relative 'person'
class Student < Person
  attr_accessor :classroom, :id, :parent_permission

  def initialize(id, name = 'Unknown', age = 0, classroom: '', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @id = id
    @classroom = classroom
    @parent_permission = parent_permission
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
