module Istwox
    class ISTC
        attr_accessor :original, :code, :weight, :check_digit

        def initialize(original)
            @original = original
            @weight = [11, 9, 3, 1] * 4
            @weight.delete_at 15
        end

        def is_valid?
        end

        def extract_code
            @original.chars.each do |c|
            end
        end


        def calculate_check_digit
        end

        def registration
        end

        def year
        end

        def textual_work
        end

        def to_s
        end
    end
end
