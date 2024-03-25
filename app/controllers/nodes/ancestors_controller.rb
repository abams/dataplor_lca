# frozen_string_literal: true

module Nodes
  class AncestorsController < ApplicationController
    # 1) /common_ancestor:
    # It should take two params, a and b, and it should return
    #   the root_id,
    #   lowest_common_ancestor_id,
    #   and depth
    # of tree of the lowest common ancestor that those two node ids share.
    def common_ancestor
      node_a = Node.find(params[:a])
      node_b = Node.find(params[:b])

      common_ancestor = Nodes::LeastCommonAncestorService.new(node_a, node_b).common_ancestor

      render json: {
        root_id: common_ancestor&.root_id,
        lowest_common_ancestor: common_ancestor&.id,
        depth: common_ancestor&.depth
      }
    end
  end
end
