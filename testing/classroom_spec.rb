require_relative '../student'
require_relative '../classroom'

RSpec.describe Classroom do
  let(:classroom) { Classroom.new('Arts') }
  let(:student1) { Student.new('Tegs') }
  let(:student2) { Student.new('Bob') }


  describe 'initializes' do
    it 'creates a new classroom' do
      expect(classroom.label).to eq('Arts')
      expect(classroom.student).to eq([])
    end
  end

  describe 'set classroom' do
    it 'assigns classroom to student' do
      student1.classroom = classroom
      expect(student1.classroom).to eq(classroom)
    end
  end

  describe 'check for students' do
    it 'returns the students in the classroom' do
      student2.classroom = classroom
      classroom.add_student(student2)
      expect(classroom.student).to contain_exactly(student2)
    end
  end

  describe 'adding student' do
    it 'adds students to the classroom' do
      classroom.add_student(student1)
      expect(student1.classroom).to eq(classroom)
      expect(classroom.student).to include(student1)

      classroom.add_student(student2)
      expect(student2.classroom).to eq(classroom)
      expect(classroom.student).to include(student2)
    end
  end
end
