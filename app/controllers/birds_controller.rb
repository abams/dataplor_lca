# frozen_string_literal: true

class BirdsController < ApplicationController
  # 2) /birds - The second requirement for this project involves considering a second model, birds.
  # Nodes have_many birds and birds belong_to nodes.
  # Our second endpoint should take an array of node ids
  # and return the ids of the birds that belong to one of those nodes or any descendant nodes.
  def index
    # node could be child of node? duplicate queries
    node_ids = params[:node_ids].split(',')
    nodes = [Node.find(node_ids)].flatten

    all_node_ids = nodes.each_with_object([]) do |node, arr|
      arr << node.id
      arr << node.ancestor_ids + node.descendant_ids
    end.uniq

    bird_ids = Bird.where(node_id: all_node_ids).pluck(:id)

    render json: { birds: bird_ids }
  end
end
