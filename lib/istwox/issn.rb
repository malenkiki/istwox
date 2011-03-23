# -*- encoding: utf-8 -*-

module Istwox
    # ISSN is an acronym for "International Standard Serial Number".
    #
    # * http://en.wikipedia.org/wiki/ISSN
    # * http://www.issn.org/
    # * http://www.oclc.org/firstsearch/periodicals/index_title.asp
    class ISSN
        attr_reader :code, :original, :ponderated, :check_digit

        def initialize(original)
            @original   = original.strip if original.is_a? String
            @ponderated = []
            @code       = []
            extract_code()
            calculate_check_digit()
            raise ArgumentError, "Not valid ISSN string" unless is_valid?
        end

        # Returns the first part of ISSN code
        def first_part
            @code[0..3]
        end

        # Returns the second part of ISSN code (with check digit)
        def second_part
            @code[4..6].push check_digit_char()
        end

        # Returns the string format of ISSN code.
        #
        # Format the ISSN code like defined into standard. For exemple, can
        # return "ISSN 2111-403X"
        def to_s
            'ISSN ' + first_part().join + '-' + second_part().join
        end

        private
        # Extract code form the given string into constructor.
        def extract_code
            @original.chars.map do |c|
                @code.push c.to_i if c[/\d+/]
            end

            if ['X','x'].include?(@original.reverse.chars.first) && @code.size == 7
                @code.push @original.reverse.chars.first.upcase
            end
        end

        # Returns check digit char.
        #
        # This is not the same value as check_digit attribute, because is
        # check digit is 10, this method returns 'X'
        def check_digit_char
            if @check_digit.eql? 10
                return 'X'
            else
                return @check_digit.to_s
            end
        end

        # Is the code given to construct the object is valid or not?
        def is_valid?
            @original.reverse.chars.first.upcase == check_digit_char()
        end

        # Calculate ponderated values
        #
        # Ponderated values are used to calculate the check digit.
        def calculate_ponderated_values
            nb_char = 8
            nb_char_cal = nb_char - 1

            @code.take(nb_char_cal).each do |c|
                @ponderated.push(c * nb_char)
                nb_char -= 1
            end
        end

        # Calculate check digit
        #
        # Calculate check digit, that must be a digit from 0 to 9, if it is
        # 10, then it is letter 'X'.
        def calculate_check_digit
            calculate_ponderated_values
            prime_number = 11

            reminder = @ponderated.inject(:+) % prime_number

            if reminder.zero?
                @check_digit = 0
            else
                @check_digit = prime_number - reminder
            end

            @check_digit
        end

    end
end

