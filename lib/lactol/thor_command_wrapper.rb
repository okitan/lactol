module Lactol
  class ThorCommandWrapper
    attr_reader :thor_class, :command_name
    attr_reader :args, :result, :error

    # @param thor_class   [Thor]
    # @param command_name [String]
    def initialize(thor_class, command_name)
      @thor_class, @command_name = thor_class, command_name
    end

    # thor command info
    def command
      thor_class.all_commands[command_name]
    end

    # execute thor command
    # @param params [Hash] parameters for thor command. keys should be symbol.
    def execute(args = {})
      @args = args

      instance = thor_class.new
      instance.options = @args

      # TODO: fork
      out,     err     = StringIO.new("out"), StringIO.new("err")
      stdout_, stderr_ = $stdout, $stderr
      begin
        $stdout, $stderr = out, err

        instance.__send__(command_name)
      ensure
        $stdout, $stderr = stdout_, stderr_
      end

      out.rewind
      err.rewind

      @result = out.read
      @error  = err.read
    end
  end
end
