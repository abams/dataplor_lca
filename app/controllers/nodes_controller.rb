require 'pry'

class NodesController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

	def common_anscestor
		a = params[:a]
		b = params[:b]

		node_a = Node.find(params[:a])
		node_b = Node.find(params[:b])

		render json: { AAAA: a, BBBB: b }
	end

	private

	def record_not_found
		render json: { error: 'not found' }, status: :not_found
	end

end
