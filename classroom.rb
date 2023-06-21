require_relative 'student'
class Classroom
    attr_accessor :label, :students
     def initialize(label)
        @label = label
        @student = []

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