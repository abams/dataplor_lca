class BirdsController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	# 2) /birds - The second requirement for this project involves considering a second model, birds.
	# Nodes have_many birds and birds belong_to nodes.
	# Our second endpoint should take an array of node ids
	# and return the ids of the birds that belong to one of those nodes or any descendant nodes.
	def nodes
		# node could be child of node? duplicate queries
		nodes = Node.find(params[:node_ids])

		all_node_ids = nodes.each_with_object([]) do |node, arr|
			arr << node.id
			arr.unshift(*node.all_children.map(&:id))
		end.uniq

		bird_ids = Bird.where(node_id: node_ids).pluck(:id)

		render json: { birds: bird_ids }
	end

	private

	def record_not_found
		render json: { error: 'not found' }, status: :not_found
	end
end
