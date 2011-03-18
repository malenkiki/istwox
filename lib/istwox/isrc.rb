module Istwox
    class ISRC
        attr_reader :code, :original

        def initialize(original)
            @orginal = original
        end

        def country_code
        end

        def registrant_code
        end

        def year
        end

        def designation_code
        end

        def to_s
        end

        private
        def is_valid?
        end

        def extract_code
        end

    end
end
