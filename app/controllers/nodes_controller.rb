require 'pry'

class NodesController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	def common_ancestor
		a = params[:a]
		b = params[:b]

		node_a = Node.find(params[:a])
		node_b = Node.find(params[:b])

		common_ancestor = Nodes::CommonAncestorService.new(node_a, node_b).find_common_ancestor

		render json: common_ancestor
	end

	private

	def record_not_found
		render json: { error: 'not found' }, status: :not_found
	end

end
