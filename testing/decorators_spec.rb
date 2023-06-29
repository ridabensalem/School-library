require_relative '../capitiliaze_decorator'
require_relative '../nameable'
require_relative '../decorator'
require_relative '../trimmer_decorator'
require_relative '../person'

RSpec.describe Decorator do
  let(:person) { Person.new(12, 'mississippi')}
  let(:book) { Book.new('book-1', 'Person')}
  let(:capitalize_person) { CapitalizeDecorator.new(person) }
  let(:trimmer) { TrimmerDecorator.new(capitalize_person) }
  let(:decorator) { Decorator.new(person) }
 
  describe 'initialize' do
    it 'sets the nameable attribute' do
      expect(decorator.correct_name).to eq('mississippi')
    end
  end

  describe 'trimmer' do
    it 'trims long text' do
      expect(trimmer.correct_name).to eq('Mississipp')
    end
  end

  describe 'capitalize' do
    it 'capitalizes first letter' do
      expect(capitalize_person.correct_name).to eq('Mississippi')
    end
  end
end
