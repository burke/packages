require 'test_helper'

class PackagesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Packages::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
