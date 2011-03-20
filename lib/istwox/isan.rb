# -*- encoding: utf-8 -*-

module Istwox
    # @attr_reader [String] original Stored string given into constructor
    # @attr_reader [Array] code Clean ISAN code
    # @attr_reader [Integer] check_digit_isan Computed check digit
    class ISAN
        attr_reader :original, :code, :check_digit_isan

        ISAN_FULL_LENGTH = 17
        ISAN_LENGTH = 16

        def initialize(original)
            @original = original
            @code = []
            
            extract_code()

            if @code.count == ISAN_FULL_LENGTH
                @code.delete_at ISAN_LENGTH
            end
            
            @check_digit_isan = compute_check_digit(@code[0, ISAN_LENGTH].join)
            
            raise ArgumentError, "Not valid ISAN string" unless is_valid?
        end

        # Get the root part
        # @return [String] A 12 digits length string
        def root
            @code[0, 12].join
        end

        # Get the episode part
        # @return [String] A 4 digits length string
        def episode
            @code[12, 4].join
        end

        # Get the root part, with hyphen
        # @see #root
        # @return [String] Root part with hyphen each 4 digits
        def root_with_hyphen
            chunk root
        end

        # Get printed format, with hyphen, 'ISAN: ' prefix and check digit
        # @return [String] String representation of ISAN code
        def to_s
            'ISAN: ' + chunk(@code[0, ISAN_LENGTH].join) + '-' + @check_digit_isan
        end

        protected
        def extract_code
            @original.upcase.chars.each do |c|
                @code.push c if c[/[A-Z0-9]+/]
            end
        end

        def is_valid?
            ((@original.upcase.reverse.chars.first == @check_digit_isan) || @code.count == ISAN_LENGTH)
        end

        # Return the given string with hyphen after each 4 characters
        # @param [String] str The string to "chunk" with hyphen
        # @return [String]
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

        # Compute the check digit
        # @note Calculus use uppercase characters
        # @return [String] The check digit, as a string
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

        VISAN_FULL_LENGTH = 26
        VISAN_LENGTH = 25

        def initialize(original)
            super
            
            # only one check digit
            if @code.count == VISAN_LENGTH
                @code.delete_at ISAN_LENGTH
            # two check digit
            elsif @code.count == VISAN_FULL_LENGTH
                @code.delete_at VISAN_LENGTH
                @code.delete_at ISAN_LENGTH
            end

            @check_digit_visan = compute_check_digit(@code.join)
            
            raise ArgumentError, "Not valid VISAN string" unless is_valid?
        end
        
        # Get version part
        # @return [String] A string of 8 digits
        def version
            @code[16, 8].join
        end

        # Get version part with hyphen
        # @see #version
        # @return [String] Same as {#version} but with hyphen in the middle
        def version_with_hyphen
            chunk version
        end

        # Printed format of the code
        # @return [String] Formated code
        def to_s
            super + '-' + version_with_hyphen + '-' + @check_digit_visan
        end
        
        private
        # @private
        # @todo Write it!
        def is_valid?
            true
            #((@original.downcase.reverse.chars.first == check_digit_isan) &&  @code.count == 13) || @code.count == 12
        end
    end
end
