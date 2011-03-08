module Istwox
    class ISSN
        attr_accessor :code, :original, :ponderated, :check_digit

        NB_CHAR      = 8
        PRIME_NUMBER = 11

        def initialize(original)
            @original   = original if original.is_a? String
            @ponderated = []
            @code       = []
            extract_code()
        end

        def extract_code
            @original.chars.map do |c|
                @code.push c.to_i if c[/\d+/]
            end
        end

        def first_part
            @code[0..3].to_s
        end

        def second_part
            @code[4..7].to_s
        end

        def check_digit_char
            if @check_digit.eql? 10
                return 'X'
            else
                return @check_digit.to_s
            end
        end

        def is_valid?
            @code[-1, 1].first.eql? @check_digit
        end

        def calculate_ponderated_values
            nb_char = NB_CHAR

            @code.take(NB_CHAR - 1).each do |c|
                @ponderated.push(c * nb_char)
                nb_char = nb_char - 1
            end
        end

        def calculate_check_digit
            calculate_ponderated_values

            sum = 0

            @ponderated.each {|p| sum = sum + p }

            reminder = sum % PRIME_NUMBER

            if reminder.zero?
                @check_digit = 0
            else
                @check_digit = PRIME_NUMBER - reminder
            end

            @check_digit
        end

        def to_s
            'ISSN ' + first_part() + '-' + second_part()
        end
    end
end

