module Istwox
    class ISAN
        attr_reader :original, :code, :check_digit_isan

        def initialize(original)
            @original = original
            @code = []
            
            extract_code()

            if @code.count == 17
                @code.delete_at 16
            end
            
            @check_digit_isan = compute_check_digit(@code[0, 16].join)
            
            raise ArgumentError, "Not valid ISAN string" unless is_valid?
        end

        def root
            @code[0, 12].join
        end

        def episode
            @code[12, 4].join
        end

        def root_with_hyphen
            chunk root
        end

        def to_s
            'ISAN: ' + chunk(@code[0, 16].join) + '-' + @check_digit_isan
        end

        protected
        def extract_code
            @original.upcase.chars.each do |c|
                @code.push c if c[/[A-Z0-9]+/]
            end
        end

        def is_valid?
            ((@original.upcase.reverse.chars.first == @check_digit_isan) || @code.count == 16)
        end

        def chunk(str)
            chunk = []
            chunk_length = 4
            start = 0

            while start < str.length do
                chunk.push(str[start...start+chunk_length])
                start += chunk_length
            end
            
            chunk.join('-')
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
        attr_reader :check_digit_visan

        def initialize(original)
            super
            
            # only one check digit
            if @code.count == 25
                @code.delete_at 16
            # two check digit
            elsif @code.count == 26
                @code.delete_at 25
                @code.delete_at 16
            end

            @check_digit_visan = compute_check_digit(@code.join)
            
            raise ArgumentError, "Not valid VISAN string" unless is_valid?
        end
        
        def version
            @code[16, 8].join
        end

        def version_with_hyphen
            chunk version
        end

        def to_s
            super + '-' + version_with_hyphen + '-' + @check_digit_visan
        end
        
        private
        # todo: write it!
        def is_valid?
            true
            #((@original.downcase.reverse.chars.first == check_digit_isan) &&  @code.count == 13) || @code.count == 12
        end
    end
end
