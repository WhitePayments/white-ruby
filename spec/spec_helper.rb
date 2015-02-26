#we need the actual library file
require_relative '../lib/white'
# For Ruby < 1.9.3, use this instead of require_relative
# require(File.expand_path('../../lib/dish', __FILE__))
 
#dependencies
gem 'minitest'
require 'minitest/autorun'