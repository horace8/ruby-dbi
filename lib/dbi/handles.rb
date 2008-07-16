#
# Dispatch classes (Handle, DriverHandle, DatabaseHandle and StatementHandle)
#

module DBI
   class Handle
      attr_reader :trace_mode, :trace_output
      attr_reader :handle 
      
      def initialize(handle)
         @handle = handle
         @trace_mode = @trace_output = nil
      end
      
      def trace(mode=nil, output=nil)
         @trace_mode   = mode   || @trace_mode   || DBI::DEFAULT_TRACE_MODE
         @trace_output = output || @trace_output || DBI::DEFAULT_TRACE_OUTPUT
      end
      
      ##
      # call a driver specific function
      #
      def func(function, *values)
         if @handle.respond_to?("__" + function.to_s) then
            @handle.send("__" + function.to_s, *values)  
         else
            raise InterfaceError, "Driver specific function <#{function}> not available."
         end
      rescue ArgumentError
         raise InterfaceError, "Wrong # of arguments for driver specific function"
      end
      
      # error functions?
   end
end

require 'dbi/handles/driver'
require 'dbi/handles/database'
require 'dbi/handles/statement'