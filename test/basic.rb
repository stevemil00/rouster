require sprintf('%s/../%s', File.dirname(File.expand_path(__FILE__)), 'path_helper')

require 'rouster'
require 'rouster/puppet'
require 'rouster/tests'

p = Rouster.new(:name => 'app', :verbosity => 1)

exit!
