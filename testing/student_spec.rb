# spec/student_spec.rb
require_relative '../person'
require_relative '../student'

RSpec.describe Student do
  let(:id) { 123 }
  let(:name) { 'John Doe' }
  let(:age) { 16 }
  let(:classroom) { 'Physics' }
  let(:parent_permission) { true }
  let(:student) { Student.new(id, name, age, classroom: classroom, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the id, name, age, classroom, parent_permission, and rentals' do
      expect(student.id).to eq(id)
      expect(student.name).to eq(name)
      expect(student.age).to eq(age)
      expect(student.classroom).to eq(classroom)
      expect(student.instance_variable_get(:@parent_permission)).to eq(parent_permission)
      expect(student.rentals).to be_an(Array)
      expect(student.rentals).to be_empty
      expect(student.instance_variable_get(:@id)).to be_an(Integer)
    end

    context 'when name is not provided' do
      let(:student) { Student.new(id, age, classroom: classroom, parent_permission: parent_permission) }

    end
  end

  describe '#play_hooky' do
    it 'returns the appropriate message' do
      expect(student.play_hooky).to eq('¯\(ツ)/¯')
    end
  end

end
