require_relative 'decorator'
class TrimmerDecorator < Decorator
  def correct_name
    return unless @nameable.correct_name.length > 10

    correct_name.strip
  end
end
