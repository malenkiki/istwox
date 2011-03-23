# -*- encoding: utf-8 -*-

module Istwox
    # ISRC is an acronym of "International Standard Recording Code".
    #
    # * http://en.wikipedia.org/wiki/ISRC
    # * http://www.ifpi.org/content/section_resources/isrc_handbook.html#Heading198
    class ISRC
        attr_reader :code, :original
        ISRC_LENGTH = 12

        def initialize(original)
            @original = original
            @code = []
            extract_code
            raise ArgumentError, "Bad ISRC code" unless is_valid?
        end

        def country_code
            @code[0, 2].join
        end

        def registrant_code
            @code[2, 3].join
        end

        def year
            @code[5, 2].join
        end

        def designation_code
            @code[7, 5].join
        end

        def to_s
            [country_code, registrant_code, year, designation_code].join('-')
        end

        private
        def is_valid?
            country_code[/[A-Z]{2,}?/] && registrant_code[/[0-9A-Z]{3,}?/]  && year[/[0-9]{2,}?/] && designation_code[/[0-9]{5,}?/] && (@code.count == ISRC_LENGTH)
        end

        def extract_code
            @original.chars.each do |c|
                if [('0'..'9').to_a,('A'..'Z').to_a].flatten!.include? c.upcase
                    @code.push c.upcase
                end
            end
        end

    end
end
