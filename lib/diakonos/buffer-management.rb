module Diakonos
  class Diakonos
    attr_reader :buffer_current

    def switch_to( buffer )
      switched = false
      if buffer
        @buffer_stack -= [ @buffer_current ]
        if @buffer_current
          @buffer_stack.push @buffer_current
        end
        @buffer_current = buffer
        @session[ 'buffer_current' ] = buffer_to_number( buffer )
        run_hook_procs( :after_buffer_switch, buffer )
        update_status_line
        update_context_line
        buffer.display
        switched = true
      end

      switched
    end

    # The given buffer_number should be 1-based, not zero-based.
    # Returns nil if no such buffer exists.
    def buffer_number_to_name( buffer_number )
      return nil if buffer_number < 1

      number = 1
      buffer_name = nil
      @buffers.each_key do |name|
        if number == buffer_number
          buffer_name = name
          break
        end
        number += 1
      end
      buffer_name
    end

    # The returned value is 1-based, not zero-based.
    # Returns nil if no such buffer exists.
    def buffer_to_number( buffer )
      number = 1
      buffer_number = nil
      @buffers.each_value do |b|
        if b == buffer
          buffer_number = number
          break
        end
        number += 1
      end
      buffer_number
    end

    def show_buffer_file_diff( buffer = @buffer_current )
      current_text_file = @diakonos_home + '/current-buffer'
      buffer.save_copy( current_text_file )
      `#{@settings[ 'diff_command' ]} #{current_text_file} #{buffer.name} > #{@diff_filename}`
      diff_buffer = open_file( @diff_filename )
      yield diff_buffer
      close_file diff_buffer
    end

  end
end