# spec/teacher_spec.rb
require_relative '../person'
require_relative '../teacher'

RSpec.describe Teacher do
  let(:id) { 456 }
  let(:name) { 'Jane Smith' }
  let(:age) { 35 }
  let(:specialization) { 'Mathematics' }
  let(:parent_permission) { true }
  let(:teacher) { Teacher.new(id, name, age, specialization: specialization, parent_permission: parent_permission) }

  describe '#initialize' do
    it 'sets the id, name, age, specialization, parent_permission, and rentals' do
      expect(teacher.id).to eq(id)
      expect(teacher.specialization).to eq(specialization)
      expect(teacher.instance_variable_get(:@parent_permission)).to eq(parent_permission)
      expect(teacher.rentals).to be_an(Array)
      expect(teacher.rentals).to be_empty
      expect(teacher.instance_variable_get(:@id)).to be_an(Integer)
    end

    context 'when name is not provided' do
      let(:teacher) { Teacher.new(id, age, specialization: specialization, parent_permission: parent_permission) }

    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to eq(true)
    end
  end

end
