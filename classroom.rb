class Classroom
  attr_accessor :label

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
  end
end
