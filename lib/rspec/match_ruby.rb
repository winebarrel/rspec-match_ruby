require 'parser/current'
require 'rspec'

require 'rspec/rspec_match_ruby'

RSpec::Matchers.define :match_ruby do |expected|
  unless expected.is_a?(String)
    raise TypeError, "wrong expected type #{expected.class} (expected String)"
  end

  match do |actual|
    unless actual.is_a?(String)
      raise TypeError, "wrong actual type #{actual.class} (expected String)"
    end

    RSpecMatchRuby.match(expected, actual)
  end

  failure_message do |actual|
    normalize = proc do |str|
      str.strip.gsub(/^\s+/, '').gsub(/[[:blank:]]+/, "\s").gsub(/\n+/, "\n").gsub(/\s+$/, '')
    end

    actual_normalized = normalize.call(actual)
    expected_normalized = normalize.call(expected)

    actual_ast = RSpecMatchRuby.parse(actual)
    expected_ast = RSpecMatchRuby.parse(expected)

    message = <<-EOS.strip
expected: #{expected_normalized.inspect}
     got: #{actual_normalized.inspect}
    EOS

    diff = RSpec::Expectations.differ.diff(actual_normalized, expected_normalized)
    ast_diff = RSpec::Expectations.differ.diff(actual_ast.pretty_inspect, expected_ast.pretty_inspect)

    if not diff.empty? or not ast_diff.empty?
      message << "\n\n" << RSpec::Matchers::ExpectedsForMultipleDiffs::DEFAULT_DIFF_LABEL
    end

    unless diff.strip.empty?
      message << diff
    end

    unless ast_diff.strip.empty?
      message << ast_diff
    end

    message
  end
end