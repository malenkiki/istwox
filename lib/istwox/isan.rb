module Istwox
    class ISAN
        attr_accessor :original, :root, :episode, :version, :check_digit_isan

        def initialize(original)
            @original = original
            # quick add, to check the good calcul of check digit, this must
            # change
            @check_digit_isan = compute_check_digit(original[0, 16])
        end

        def compute_check_digit(str)
            s = as = p = ap = 0
            mod_one = 37
            mod_two = mod_one - 1

            str.downcase.chars.map.with_index do |c, i|
                if c[/\d+/]
                    s = c[/\d+/].to_i
                else
                    s = c.ord - 87
                end

                s = s + mod_two if i.zero?
                s = s + ap      if i > 0

                as = s
                as = s - mod_two if s > mod_two

                as = mod_two if as.zero?

                p = as * 2

                ap = p
                ap = p - mod_one if p >= mod_one
            end

            return '0'                     if ap == 1
            return (mod_one - ap).to_s     if (mod_one - ap < 10)
            return (mod_one - ap + 55).chr if (mod_one - ap >= 10)
        end

    end

    class VISAN < ISAN
        attr_accessor :check_digit_visan

        def initialize(original)
            @original = original
            # quick add, to check the good calcul of check digit, this must
            # change
            @check_digit_visan = compute_check_digit(original)
        end
    end
end
