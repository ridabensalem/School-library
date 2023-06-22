require_relative 'student'
class Classroom
  attr_accessor :label, :student

  def initialize(label)
    @label = label
    @student = []
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def students
    Student.all.select do |student|
      student.classroom == self
    end
  end

  def add_student(student)
    student.classroom = self
    @students << student unless @students.include?(student)
  end
end
