# -*- encoding: utf-8 -*-

module Istwox
    # ISTC is an acronym for "International Standard Text Code".
    #
    # This class allow you to extract some code parts, compute check digit, check validity…
    #
    # For more information, see this link:
    # * http://en.wikipedia.org/wiki/International_Standard_Text_Code
    # * http://www.istc-international.org/
    # * http://www.istc-international.org/html/all_about_istc.aspx#structure
    #
    # @attr_reader [String] original Original given string
    # @attr_reader [Array] code Extracted code
    # @attr_reader [Array] weight Weights used to compute check digit
    # @attr_reader [String] check_digit Check digit char
    class ISTC
        attr_reader :original, :code, :weight, :check_digit

        # todo: put is_valid to raise exception in some cases…
        #
        # @see #extract_code
        # @see create_weight_index
        # @see calculate_check_digit
        def initialize(original)
            @original = original
            @code = []
            extract_code
            create_weight_index
            calculate_check_digit
        end


        # Get the registration part.
        #
        # @return [String] A string of three chars.
        def registration
            @code[0, 3].join
        end

        # Get the year part
        #
        # @return [String] A string of 4 digits.
        def year
            @code[3, 4].join
        end

        # Get the textual work part
        #
        # @return [String] A string of height chars.
        def textual_work
            @code[7, 8].join
        end

        # Printed format of ISTC code.
        #
        # @return [String] A string with hyphens and ISTC prefix.
        def to_s
            'ISTC ' + registration() + '-' + year() + '-' + textual_work() + '-' + @check_digit
        end
        
        private
        # Create weighted index used to compute check digit.
        #
        # The pattern is 4 numbers 11, 9, 3 and 1 repeated 4 times from left to right.
        #
        # @private
        def create_weight_index
            @weight = [11, 9, 3, 1] * 4
            @weight.delete_at 15
        end

        # Compute the sum of the product of the code with its weighted values.
        #
        # @private
        # @return [Integer] The sum computed
        def calculate_weight_sum
            sum = 0

            @code.take(15).map.with_index do |v, k|
                sum += v.to_i(16) * @weight[k]
            end

            sum
        end

        # @todo The valid method must to do.
        # @private
        # @return [Boolean]
        def is_valid?
        end

        # Extract from string given into constructor meaning characters.
        #
        # @private
        def extract_code
            @original.chars.each do |c|
                if [('0'..'9').to_a,('A'..'F').to_a].flatten!.include? c.upcase
                    @code.push c.upcase
                end
            end
        end

        # Compute the check digit and set it as attribute.
        #
        # @private
        def calculate_check_digit
            @check_digit = (calculate_weight_sum % 16).to_s(16).upcase
        end
    end
end
