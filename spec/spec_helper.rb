require 'rubygems'
require 'bundler/setup'

require 'rspec'

require 'time'

if RUBY_VERSION < "1.9" && !defined?(JRUBY_VERSION)
  require 'ruby-debug'
end

Dir['./spec/support/**/*.rb'].map {|f| require f}

$:.push File.expand_path("../lib", __FILE__)
require 'cosm-rb'

require File.dirname(__FILE__) + '/fixtures/models.rb'

RSpec.configure do |c|
  c.run_all_when_everything_filtered = true
end
