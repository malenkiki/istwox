# -*- encoding: utf-8 -*-

module Istwox
    # ISRC is an acronym of "International Standard Recording Code".
    #
    # * http://en.wikipedia.org/wiki/ISRC
    # * http://www.ifpi.org/content/section_resources/isrc_handbook.html#Heading198
    #
    # @attr_reader [Array] Extracted code
    # @attr_reader [String] Original given string
    class ISRC
        attr_reader :code, :original

        # Length of valid ISRC code
        ISRC_LENGTH = 12

        # Constructor
        #
        # @param [String] original The string from witch we want the code
        # @raise [ArgumentError] When ISRC code is not valid
        def initialize(original)
            @original = original
            @code = []
            extract_code
            raise ArgumentError, "Bad ISRC code" unless is_valid?
        end

        # Get the country code part
        #
        # @return [String] String of 2 chars
        def country_code
            @code[0, 2].join
        end

        # Get the registrant code
        #
        # @return [String] String of 3 chars
        def registrant_code
            @code[2, 3].join
        end

        # Get the year part
        #
        # @note The year is only defined by its 2 last digits.
        #
        # @return [String] String of 2 chars
        def year
            @code[5, 2].join
        end

        # Get designation code part
        #
        # @return [String] String of 5 digits
        def designation_code
            @code[7, 5].join
        end

        # Get the printed string format
        #
        # @return [String] The code with hyphen to distinguish parts
        def to_s
            [country_code, registrant_code, year, designation_code].join('-')
        end

        private
        def is_valid?
            country_code[/[A-Z]{2,}?/] && registrant_code[/[0-9A-Z]{3,}?/]  && year[/[0-9]{2,}?/] && designation_code[/[0-9]{5,}?/] && (@code.count == ISRC_LENGTH)
        end

        # Extract from string chars used for the code
        def extract_code
            @original.chars.each do |c|
                if [('0'..'9').to_a,('A'..'Z').to_a].flatten!.include? c.upcase
                    @code.push c.upcase
                end
            end
        end

    end
end
