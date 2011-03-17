module Istwox
    class ISTC
        attr_reader :original, :code, :weight, :check_digit

        # todo: put is_valid to raise exception in some cases…
        def initialize(original)
            @original = original
            @code = []
            extract_code
            create_weight_index
            calculate_check_digit
        end


        def registration
            @code[0, 3].join
        end

        def year
            @code[3, 4].join
        end

        def textual_work
            @code[7, 8].join
        end

        def to_s
            'ISTC ' + registration() + '-' + year() + '-' + textual_work() + '-' + @check_digit
        end
        
        private
        def create_weight_index
            @weight = [11, 9, 3, 1] * 4
            @weight.delete_at 15
        end

        def calculate_weight_sum
            sum = 0

            @code.take(15).map.with_index do |v, k|
                sum += v.to_i(16) * @weight[k]
            end

            sum
        end

        # todo
        def is_valid?
        end

        def extract_code
            @original.chars.each do |c|
                if [('0'..'9').to_a,('A'..'F').to_a].flatten!.include? c.upcase
                    @code.push c.upcase
                end
            end
        end

        def calculate_check_digit
            @check_digit = (calculate_weight_sum % 16).to_s(16).upcase
        end
    end
end
