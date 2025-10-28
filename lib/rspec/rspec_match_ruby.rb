module RSpecMatchRuby
  DEFAULT_DIFF_LABEL = "Diff:".freeze

  def parse(str)
    node = Parser::CurrentRuby.parse(str)
    expand_node(node)
  end
  module_function :parse

  def match(expected, actual)
    parse(expected) == parse(actual)
  end
  module_function :match

  def expand_node(node)
    return nil if node.nil?

    children = node.children

    if node.type == :hash
      children = node.children.sort_by(&:to_s)
    end

    children = children.map do |child|
      if child.is_a?(Parser::AST::Node)
        expand_node(child)
      else
        child
      end
    end

    [node.type, *children]
  end
  module_function :expand_node
end
