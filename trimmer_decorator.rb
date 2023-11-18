require_relative 'decorator'

class TrimmerDecorator < Decorator
  def correct_name
    original_name = @nameable.correct_name
    original_name.length <= 10 ? original_name : original_name[0..9]
  end
end
