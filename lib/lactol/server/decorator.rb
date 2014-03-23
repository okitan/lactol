require "delegate"

require "lactol/server/view_helper"

module Lactol
  class Server
    class Decorator < SimpleDelegator
      include ViewHelper

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
        command.options[:as] || self.class.name
      end
    end
  end
end
