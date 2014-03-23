$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lactol'

require "thor"
require "capybara"

require "pry" # for debug

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = 'random'
end
