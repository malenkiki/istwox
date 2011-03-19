module Istwox
    # This class can extract ISBN code, check its validity, and compute its check digit.
    #
    # You can also get some part of the code, like GS1 prefix, group identifier…
    #
    # @note The ISBN format is the one that taked place in 2007, replacing
    #    ISBN old format on 10 digits. To use this old format, please use
    #    {ISBN10} class.
    #
    # To have more information about ISBN format, please see following links:
    # * http://en.wikipedia.org/wiki/ISBN
    # * http://www.iso.org/iso/iso_catalogue/catalogue_tc/catalogue_detail.htm?csnumber=36563
    #
    # @attr_reader [Array] code ISBN code extracted form string of constructor param
    # @attr_reader [String] original Original string passed to constructor
    # @attr_reader [Array] ponderated Ponderated values used to calculate check digit
    # @attr_reader [Integer] check_digit The computed check digit
    class ISBN
        attr_reader :code, :original, :ponderated, :check_digit
        
        # The full code length by its meaning digits *including* the check digit
        ISBN_FULL_LENGTH = 13

        # The code length by its meaning digits *without* the check digit
        ISBN_LENGTH = 12

        # Constructor take one parameter, an ISBN String, with or without
        # hyphen, with or without ISBN prefix letters.
        #
        # Behind the scene, two important things take place:
        # * extacting code with {#extract_code} method to have code clean
        # * computing the check digit with {#calculate_check_digit} method
        #
        # If the given parameter is an invalid ISBN code, i.e. with to more
        # digits or with bad check digit, then the constructor raises an
        # ArgumentError exception.
        # 
        # @example Instanciate with complete ISBN string
        #   isbn = Istwox::ISBN.new "ISBN 978-2-03-585437-7"
        # @example Instanciate with ISBN code string
        #   isbn = Istwox::ISBN.new "978-2-03-585437-7"
        # @example Instanciate with ISBN code string without hyphen
        #   isbn = Istwox::ISBN.new "9782035854377"
        # @example Instanciate with ISBN code string w/o hyphen and w/o check digit
        #   isbn = Istwox::ISBN.new "978203585437"
        # @param [String] original An ISBN string 
        def initialize(original)
            @original   = original.strip if original.is_a? String
            @ponderated = []
            @code       = []
            extract_code()
            calculate_check_digit()
            raise ArgumentError, "Not valid ISBN string" unless is_valid?
        end

        # @todo create ISBN object from ISBN10 string old format
        # @return [ISBN] An ISBN object
        def create_from_old(old_format)
        end
        
        # Get the GS1 prefix, 978 or 979
        # @return [String] three digits of GS1 prefix
        def gs1_prefix
            @code[0..2].join
        end

        # Get the group identifier
        #
        # The length of this part is variable. digits or ranges available are the followings:
        # * part in one digit, with 0, 1, 2, 3, 4, 5, or 7
        # * two digits in range [80, 94]
        # * three digits in ranges [600, 617] or [950, 989]
        # * four digits in range [9927, 9989]
        # * five digits in range [99901, 99967]
        #
        # @return [String] The group identifier string (from one to five digits)
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

        # Get the publisher and title parts together.
        #
        # See the note on the method #to_s to understand why the two parts are together.
        # 
        # @return [String] Publisher and title parts in a string
        def publisher_code_and_title
            @code[(group_identifier.length + 3)..11].join
        end

        # Returns the string format into EAN-13 code.
        #
        # @note There are not free method available to have ISBN-13 code with hyphen
        #   to see groups. The groups "publisher" and "title" cannot be split.
        #   So, only EAN-13 (without hyphen) can be get.
        #   If you want other groups than "publisher" and "title", see other
        #   methods {#gs1_prefix} and {#group_identifier} into this class.
        #
        # @return [String] EAN-13 formated string of ISBN.
        def to_s
            @code.join + @check_digit.to_s
        end


        private
        # Extract code from the given string into constructor.
        # @private
        def extract_code
            @original.chars.map do |c|
                @code.push c.to_i if c[/\d+/]
            end
        end


        # Is the code given to construct the object is valid or not?
        def is_valid?
            ((@original.reverse.chars.first.to_i == check_digit) && (['978', '979'].include? gs1_prefix) && @code.count == ISBN_FULL_LENGTH) || @code.count == ISBN_LENGTH
        end

        # Calculate ponderated values
        #
        # Ponderated values are used to calculate the check digit.
        def calculate_ponderated_values
            1.upto(ISBN_LENGTH) do |i|
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
    end



    # Old format ISBN on 10 digits
    #
    # @note This is the old format, since 2007, you must use {ISBN} on 13 digits
    #   (EAN-like format)
    class ISBN10 < ISBN
        ISBNX_FULL_LENGTH = 10
        ISBNX_LENGTH = 9

        private
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
            nb_char     = ISBNX_FULL_LENGTH

            @code.take(ISBNX_LENGTH).each do |c|
                @ponderated.push(c * nb_char)
                nb_char = nb_char.pred
            end
        end

        def is_valid?
        end
    end
end
