# -*- encoding: utf-8 -*-

module Istwox
    class ISMN
        attr_reader :code, :original, :ponderated, :check_digit

        def initialize(original)
            @original   = original.strip if original.is_a? String
            @ponderated = []
            @code       = []
            extract_code()
            calculate_check_digit()
            raise ArgumentError, "Not valid ISMN string" unless is_valid?
        end

        # todo
        def create_from_old(old_format)
        end

        def gs1_prefix
            @code[0..2].join
        end

        def publisher
            g = @code[4]

            if ('000'..'099').include? @code[4, 3].join
                return @code[4, 3].join
            elsif ('1000'..'3999').include? @code[4, 4].join
                return @code[4, 4].join
            elsif ('40000'..'69999').include? @code[4, 5].join
                return @code[4, 5].join
            elsif ('700000'..'899999').include? @code[4, 6].join
                return @code[4, 6].join
            elsif ('9000000'..'9999999').include? @code[4, 7].join
                return @code[4, 7].join
            else
                raise ArgumentError, "Publisher does not follow ISMN standard"
            end
        end

        def item
            @code[(publisher.length + 4)..11].join
        end
        
        # TODO: Unlike ISBN, we can get code with separated group.
        def to_s
            if @code.count < 13
                @code.join + @check_digit.to_s
            else
                @code.join
            end
        end


        private
        # Extract code form the given string into constructor.
        def extract_code
            @original.chars.map do |c|
                @code.push c.to_i if c[/\d+/]
            end
        end

        # Is the code given to construct the object is valid or not?
        def is_valid?
            ((@original.reverse.chars.first.to_i == check_digit) && (gs1_prefix == '979') && @code.count == 13) || @code.count == 12
        end

        # Calculate ponderated values
        #
        # Ponderated values are used to calculate the check digit.
        def calculate_ponderated_values
            1.upto(12) do |i|
                c = @code[i - 1]
                if c
                    c *= 3 if i.even?
                    @ponderated.push c
                end
            end
        end

        # Calculate check digit
        #
        # Calculate check digit, that must be a digit from 0 to 9
        def calculate_check_digit
            calculate_ponderated_values
            @check_digit = 10 - (@ponderated.inject(:+) % 10)
        end

    end

end
