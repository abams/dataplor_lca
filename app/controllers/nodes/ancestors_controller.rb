# frozen_string_literal: true

class Nodes::AncestorsController < ApplicationController
  # 1) /common_ancestor:
  # It should take two params, a and b, and it should return
  #   the root_id,
  #   lowest_common_ancestor_id,
  #   and depth
  # of tree of the lowest common ancestor that those two node ids share.
  def index
    params[:a]
    params[:b]

    node_a = Node.find(params[:a])
    node_b = Node.find(params[:b])

    common_ancestor = Nodes::CommonAncestorService.new(node_a, node_b).find_common_ancestor

    render json: common_ancestor
  end
end
