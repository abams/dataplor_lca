module Nodes
	class CommonAncestorService

		def initialize(node_a, node_b)
			@node_a = node_a
			@node_b = node_b
			@paths = { left: [@node_a&.id], right: [@node_b&.id] }
		end

		def find_common_ancestor
			return nil if @node_a.nil? || @node_b.nil? 
			# return @node_a if @node_a.id == @node_b.id
			
			common_ancestor = (@paths[:left] & @paths[:right]).first
			
			if common_ancestor.present? 
				# TODO: make the depth better, maybe rearranging the node lookup
				# This is because we've already queried the first node, we can refactor this
				# binding.pry

				# this is kind of jank - find a better way to find depth
				depth = [@paths[:left].find_index(common_ancestor), @paths[:right].find_index(common_ancestor)].max + 1
				root_id, depth = find_root(common_ancestor, 0)

				# This is also jank
				# depth = 1 if root_id == common_ancestor

				return { root_id: root_id, common_ancestor_id: common_ancestor, depth: depth }
			end

			# binding.pry
			# TODO: We need to do something here to get the root ... keep going
			left_parent_id = Node.find(@paths[:left].last).parent_id
			right_parent_id = Node.find(@paths[:right].last).parent_id

			return { root_id: nil , common_ancestor_id: nil , depth: nil } if left_parent_id.nil? and right_parent_id.nil?

			@paths[:left] << left_parent_id if left_parent_id
			@paths[:right] << right_parent_id if right_parent_id

			find_common_ancestor
		end

		private

		def find_root(node_id, depth)
			# binding.pry
			root_id = node_id

			until node_id.nil?
				depth += 1
				# binding.pry
				root_id = node_id
				node_id = Node.find(node_id).parent_id
			end

			[root_id, depth]
		end


		# def find_common_ancestor
		# 	return nil if @node_a.nil? || @node_b.nil? 

		# 	return @node_a if @node_a.id == @node_b.id

		# 	nodes = [@node_a, @node_b]
		# 	visited = { @node_a.id => [], @node_b.id => [] }

		# 	until nodes.empty? 
		# 		current = queue.shift

		# 		return current if is_common_ancestor?(current)

		# 		current_parent = Node.find_by(id: current.parent_id)
		# 		next if current_parent.nil? || visited[current_parent]

		# 		queue << current_parent
		# 		visited[current_parent] << current_parent.id
		# 	end

		# 	nil
		# end

		# private

		# def is_common_ancestor?(node)
		# 	node == @node_a || node == @node_b
		# end
	end
end
