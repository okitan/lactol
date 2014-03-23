#!/usr/bin/env ruby

require "bundler/setup"

require "thor"

class ExampleCLI < Thor
  desc "command", "command"
  method_option :required_option, required: true
  method_option :optional_option
  def command
    puts "command"
    warn "warning"
  end
end

require "lactol"
require "rack"

options = Rack::Server::Options.new.parse!(ARGV)

app = Rack::Builder.new do
  run Lactol::Server.new(ExampleCLI)
end

Rack::Server.start(options.merge(app: app))
