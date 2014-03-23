require "lactol/thor_command_wrapper"

module Lactol
  class ThorWrapper
    attr_reader :thor_class

    # @param thor_class [Thor]
    def initialize(thor_class)
      @thor_class = thor_class
    end

    def commands
      thor_class.all_commands
    end

    def command(command_name)
      ThorCommandWrapper.new(thor_class, command_name)
    end

    def has_command?(command_name)
      commands.has_key?(command_name)
    end
  end
end
