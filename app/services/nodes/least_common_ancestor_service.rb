# frozen_string_literal: true

module Nodes
  class LeastCommonAncestorService
    attr_reader :node_a, :node_b

    # params [Node] node_a first node to traverse
    # params [Node] node_b first node to traverse
    def initialize(node_a, node_b)
      @node_a = node_a
      @node_b = node_b
    end

    def common_ancestor
      @common_ancestor ||= Node.find(common_ancestor_id) if common_ancestor_id
    end

    private

    def common_ancestor_id
      @common_ancestor_id ||= if node_a && node_b
        [node_a.ancestor_ids << node_a.id & node_b.ancestor_ids << node_b.id].last[-1]
      end
    end
  end
end
