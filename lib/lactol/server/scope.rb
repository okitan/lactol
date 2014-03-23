require "lactol/server/view_helper"

module Lactol
  class Server
    class Scope
      attr_reader   :thor_class, :command_name, :options
      # these are for result
      attr_accessor :args, :out, :err

      include ViewHelper

      # @param thor_class   [Thor]
      # @param command_name [String]
      # @param options      [Hash] configuration of lactol
      def initialize(thor_class, command_name, options)
        @thor_class, @command_name, @options = thor_class, command_name, options
      end

      def command
        thor_class.all_commands[command_name]
      end

      def parameters
        command.options
      end

      def mandatory_parameters
        parameters.select {|option_name, option_param| option_param.required }
      end

      def optional_parameters
        parameters.select {|option_name, option_param| ! option_param.required }
      end

      def title
        "#{thor_name} #{command_name} - lactol"
      end

      def thor_name
        options[:as] || thor_class.name
      end
    end
  end
end
