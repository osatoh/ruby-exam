require 'csv'

class CheckingAnswer
  attr_reader :answers, :own_answers

  def initialize(answer_path, own_answer_path)
    @answers = CSV.read(answer_path, headers: true)
    @own_answers = CSV.read(own_answer_path, headers: true)
  end

  def check
    incorrect_answers = []
    own_answers.each_with_index do |row, i|
      next if row['Answer'].split(',') == answers[i][1].split(',')

      incorrect_answers << i + 1
    end

    print_report(incorrect_answers)
  end

  def print_report(incorrect_answers)
    puts "正答率: #{(1 - incorrect_answers.size.to_f / answers.count) * 100}%"
    puts incorrect_answers
  end
end

answer_path = ARGV[0]
own_answer_path = ARGV[1]
CheckingAnswer.new(answer_path, own_answer_path).check
