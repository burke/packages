# Packages

This is a proof-of-concept package system for Ruby. It doesn't Just Work™, as
it relies on a feature not present in ruby (https://github.com/burke/ruby/pull/1).

See
[`test/packages_test.rb`](/test/packages_test.rb)
for an example of how this works. The general feel is:

```ruby
#### a.rb
package 'a'
import 'b'

module A
  def self.x
    B.y # ok
    C.z # raises VisibilityError
  end
end

#### b.rb
package 'b'
module B
  def self.y; end
end

#### c.rb
package 'c'
module C
  def self.z; end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

