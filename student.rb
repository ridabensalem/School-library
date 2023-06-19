require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(id, name = 'Unknown', age = 0, classroom:, parent_permission: true)
    super(id, name, age, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end

class Teacher < Person
  attr_accessor :specialization

  def initialize(id, name = 'Unknown', age = 0, specialization:, parent_permission: true)
    super(id, name, age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
