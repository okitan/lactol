require "slim"
require "tilt"

require "lactol/server/decorator"
require "lactol/thor_wrapper"

module Lactol
  class Server
    attr_reader :thor, :options

    def initialize(thor_class, options = {})
      @thor, @options = ThorWrapper.new(thor_class), options
    end

    def call(env)
      request = Rack::Request.new(env)

      command = request.path[1..-1]
      if thor.has_command?(command)
        case request.request_method
        when "GET"
          render_form(command)
        when "POST"
          execute_command(command, request.POST)
        else
          # TODO: 405
        end
      else
        if comman.empty?
          # index
        else
          # TODO: 404
        end
      end
    end

    protected
    def render_form(command)
      command = thor.command(command)

      [ "200",
        { "Content-Type" => "text/html",
        },
        [ Tilt.new(form_template).render(Decorator.new(command)) ]
      ]
    end

    def execute_command(command, args)
      # TODO: white list it
      args = args.each.with_object({}) {|(key, value), hash| hash[key.to_sym] = value }

      command = thor.command(command)
      command.execute(args)

      [ "200",
        { "Content-Type" => "text/html",
        },
        [ Tilt.new(result_template).render(Decorator.new(command)) ]
      ]
    end

    def form_template
      File.expand_path("templates/form.slim", File.dirname(__FILE__))
    end

    def result_template
      File.expand_path("templates/result.slim", File.dirname(__FILE__))
    end
  end
end
