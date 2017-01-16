$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'packages'

require 'minitest/autorun'

Dir.glob(File.expand_path('../fixtures/*.rb', __FILE__)).each do |f|
  require f
end
