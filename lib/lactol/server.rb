require "slim"
require "tilt"

require "lactol/server/scope"

module Lactol
  class Server
    attr_reader :thor_class, :options

    def initialize(thor_class, options = {})
      @thor_class, @options = thor_class, options
    end

    def call(env)
      request = Rack::Request.new(env)

      command = request.path[1..-1]
      case request.request_method
      when "GET"
        unless command.empty?
          render_form(command)
        else
          # TODO: /
        end
      when "POST"
        execute_command(command, request.POST)
      else
        # TODO: 405
      end
    end

    protected
    def scope(command)
      Lactol::Server::Scope.new(thor_class, command, options)
    end

    def render_form(command)
      commands = thor_class.all_commands
      if commands.has_key?(command)
        [ "200",
          { "Content-Type" => "text/html",
          },
          [ Tilt.new(form_template).render(scope(command)) ]
        ]
      else
        puts "404"
        # TODO: 404
      end
    end

    def execute_command(command, args)
      # TODO: white list it
      args = args.each.with_object({}) {|(key, value), hash| hash[key.to_sym] = value }

      instance = thor_class.new
      instance.options = args

      out,     err     = StringIO.new("out"), StringIO.new("err")
      stdout_, stderr_ = $stdout, $stderr
      # TODO: fork
      begin
        $stdout, $stderr = out, err

        instance.__send__(command)
      ensure
        $stdout, $stderr = stdout_, stderr_
      end

      result_scope = scope(command)
      result_scope.args = args
      out.rewind
      result_scope.out  = out.read
      err.rewind
      result_scope.err  = err.read

      [ "200",
        { "Content-Type" => "text/html",
        },
        [ Tilt.new(result_template).render(result_scope) ]
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
