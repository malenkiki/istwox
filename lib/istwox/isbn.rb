module Istwox
    class ISBN
        attr_accessor :code, :original, :ponderated, :check_digit

        def initialize(original)
            @original   = original.strip if original.is_a? String
            @ponderated = []
            @code       = []
            extract_code()
            calculate_check_digit()
            raise ArgumentError, "Not valid ISBN string" unless is_valid?
        end

        # Extract code form the given string into constructor.
        def extract_code
            @original.chars.map do |c|
                @code.push c.to_i if c[/\d+/]
            end
        end

        # Get the GS1 prefix, 978 or 979
        def gs1_prefix
            @code[0..2].join
        end

        def group_identifier
            g = @code[3]

            if [0, 1, 2, 3, 4, 5, 7].include? g
                return g.to_s
            elsif (600..617).include? @code[3, 3].join
                return @code[3, 3].join
            elsif (80..94).include? @code[3, 2].join
                return @code[3, 2].join
            elsif (950..989).include? @code[3, 3].join
                return @code[3, 3].join
            elsif (9927..9989).include? @code[3, 4].join
                return @code[3, 4].join
            elsif (99901..99967).include? @code[3, 5].join
                return @code[3, 5].join
            else
                raise ArgumentError, "Group Identifier does not follow ISBN standard"
            end
        end

        def publisher_code_and_title
            @code[(group_identifier.length + 3)..11].join
        end


        # Is the code given to construct the object is valid or not?
        def is_valid?
            ((@original.reverse.chars.first.to_i == check_digit) && (['978', '979'].include? gs1_prefix) && @code.count == 13) || @code.count == 12
        end

        # Calculate ponderated values
        #
        # Ponderated values are used to calculate the check digit.
        def calculate_ponderated_values
            1.upto(12) do |i|
                c = @code[i - 1]
                c *= 3 if i.even?
                @ponderated.push c
            end
        end

        # Calculate check digit
        #
        # Calculate check digit, that must be a digit from 0 to 9
        def calculate_check_digit
            calculate_ponderated_values
            @check_digit = (10 - (@ponderated.inject(:+) % 10)) % 10
        end

        # Returns the string format into EAN-13 code.
        #
        # There are not free method available to have ISBN-13 code with hyphen
        # to see groups. The groups "publisher" and "title" cannot be split.
        # So, only EAN-13 (without hyphen) can be get.
        # If you want other group than "publisher" and "title", see other
        # method into this class.
        def to_s
            @code.join + @check_digit.to_s
        end

        protected :extract_code, :calculate_check_digit, :is_valid?, :calculate_ponderated_values
    end

    class ISBN10 < ISBN
        # Extract code form the given string into constructor.
        def extract_code
            @original.chars.map do |c|
                @code.push c.to_i if c[/\d+/]
            end

            if ['X','x'].include?(@original.reverse.chars.first) && @code.size == 9
                @code.push @original.reverse.chars.first.upcase
            end
        end
        
        # Calculate ponderated values
        #
        # Ponderated values are used to calculate the check digit.
        def calculate_ponderated_values
            nb_char = 10
            nb_char_cal = nb_char - 1

            @code.take(nb_char_cal).each do |c|
                @ponderated.push(c * nb_char)
                nb_char = nb_char.pred
            end
        end
    end
end
