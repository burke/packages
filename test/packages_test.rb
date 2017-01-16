require 'test_helper'

##########################################
package 'foopkg'
import 'barpkg'

module Foo
  def self.invalid_cross_package_access
    Baz # loaded by test_helper, not imported (bazpkg)
  end

  def self.valid_cross_package_access
    Bar # loaded by test_helper, imported (barpkg)
  end

  def self.no_cross_package_access
    FooNested # same package
    String # not in a package
  end

  module FooNested
  end
end

##########################################

class PackagesTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Packages::VERSION
  end

  def test_package_access_rules
    assert_raises(VisibilityError) do
      Foo.invalid_cross_package_access
    end
    Foo.valid_cross_package_access # (refute raise)
    Foo.no_cross_package_access # (refute raise)
  end
end
